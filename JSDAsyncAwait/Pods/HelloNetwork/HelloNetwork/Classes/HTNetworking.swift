//
//  HTNetworking.swift
//  RequestDemo
//
//  Created by brant on 2018/7/19.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class HTNetworking: HTNetworkingProtocol {
    
    static let shared = HTNetworking()
    
    var typeName: String {
        return "HTNetworking"
    }
    
    /// 存放已经发送的请求，用来取消请求用，key为请求的唯一标识
    var requests: Dictionary<String, Request> = [:]
    
    let lock = NSLock()
    
    func addRequest(request: HTRequest, netRequest: Request) {
        lock.lock()
        self.requests[request.identifier] = netRequest
        lock.unlock()
    }
    
    func removeRequest(identifier: String) {
        lock.lock()
        self.requests.removeValue(forKey: identifier)
        lock.unlock()
    }
    
    func request(identifier: String) -> Request? {
        lock.lock()
        let request = self.requests[identifier]
        lock.unlock()
        
        return request
    }
    
    /// 取消请求
    ///
    /// - Parameter identifier: 请求的唯一标识
    func cancel(identifier: String) {
        
        if let request = self.request(identifier: identifier) {
            request.cancel()
            removeRequest(identifier: identifier)
        }
    }
    
    func response(with error: Error) {
        if error._code == NSURLErrorTimedOut {
            
        }
    }
    
    /// 发送一个上传或者数据请求
    ///
    /// - Parameter request: 请求参数
    /// - Returns: observable
    func send(request: HTRequest) -> Observable<HTResponse> {
        
        return Observable.create({ (observer) -> Disposable in
            do {
                let urlRequest = try request.asURLRequest()
                self.dataRequest(request: request, urlRequest: urlRequest, observer: observer)
                
            } catch let error as HTNetworkError {
                let result = HTResponse(response: nil, request: request, data: nil, error: error)
                result.htError = error
                observer.onNext(result)
                observer.onCompleted()
            } catch {
                let result = HTResponse(response: nil, request: request, data: nil, error: error)
                result.htError = HTNetworkError.unknow
                observer.onNext(result)
                observer.onCompleted()
            }
            
            return Disposables.create()
        })
    }
    
    func dataRequest(request: HTRequest, urlRequest: URLRequest, observer: RxSwift.AnyObserver<HTResponse>) {
        // 用alamofire发起网络请求
        let dataRequest = Alamofire.request(urlRequest)
            .responseData(completionHandler: { [weak self] (response) in
                
                request.requestStartTime = response.timeline.requestStartTime
                request.initialResponseTime = response.timeline.initialResponseTime
                request.requestCompletedTime = response.timeline.requestCompletedTime
                
                switch response.result {
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        let result = HTResponse(response: response.response, request: request, data: nil, error: error)
                        result.htError = HTNetworkError.timeout
                        observer.onNext(result)
                    } else {
                        let result = HTResponse(response: response.response, request: request, data: nil, error: error)
                        result.htError = HTNetworkError.netError
                        observer.onNext(result)
                    }
                    
                case .success(let data):
                    // 请求成功
                    observer.onNext(HTResponse(response: response.response, request: request, data: data))
                }
                
                // 请求完成后，要把请求从列表中移除
                self?.removeRequest(identifier: request.identifier)
                
                observer.onCompleted()
            })
        
        self.addRequest(request: request, netRequest: dataRequest)
    }
    
    
    /// 发送一个下载请求
    ///
    /// - Parameter request: 请求参数
    /// - Returns: observable
    func download(request: HTRequest) -> Observable<HTProgressResponse>? {
        
        return Observable.create({ (observer) -> Disposable in
            
            guard let downloadDestination = request.downloadDestination else {
                
                // 这里要加一个错误 返回
                let error = NSError(domain: "下载地址未指定", code: 2011, userInfo: nil)
                observer.onError(error)
                
                return Disposables.create()
            }
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                let fileURL = URL(fileURLWithPath: downloadDestination)
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            
            do {
                let url = try request.asURLRequest()
                
                let downloadRequest = Alamofire.download(url, to: destination)
                    .response { [weak self] (response) in
                        
                        request.requestStartTime = response.timeline.requestStartTime
                        request.initialResponseTime = response.timeline.initialResponseTime
                        request.requestCompletedTime = response.timeline.requestCompletedTime
                        
                        if let error = response.error {
                            // 请求出错了
                            observer.onError(error)
                        }
                        else {
                            observer.onNext(HTProgressResponse.result(response: HTResponse(response: response.response, request: request, data: nil, destinationURL: response.destinationURL)))
                        }
                        
                        // 请求完成后，要把请求从列表中移除
                        self?.removeRequest(identifier: request.identifier)
                        
                        observer.onCompleted()
                    }
                    .downloadProgress { (progress) in
                        observer.onNext(HTProgressResponse.progress(progress: progress))
                }
                
                self.addRequest(request: request, netRequest: downloadRequest)
                
            } catch {
                
                // 捕获url构建错误
                observer.onError(error)
            }
            
            return Disposables.create()
        })
        
    }
}

/// block 回调方法
extension HTNetworking {
    /// block回调的http请求
    func send(request: HTRequest, result: @escaping (HTResponse) -> ()) {
        do {
            let urlRequest = try request.asURLRequest()
            
            request.cancel()
            
            // 用alamofire发起网络请求
            let dataRequest = Alamofire.request(urlRequest)
                .responseData(completionHandler: { [weak self] (response) in
                    
                    request.requestStartTime = response.timeline.requestStartTime
                    request.initialResponseTime = response.timeline.initialResponseTime
                    request.requestCompletedTime = response.timeline.requestCompletedTime
                    
                    switch response.result {
                    case .failure(let error):
                        if error._code == NSURLErrorTimedOut {
                            let res = HTResponse(response: response.response, request: request, data: nil, error: error)
                            res.htError = HTNetworkError.timeout
                            result(res)
                        } else {
                            let res = HTResponse(response: response.response, request: request, data: nil, error: error)
                            res.htError = HTNetworkError.netError
                            result(res)
                        }
                        
                    case .success(let data):
                        // 请求成功
                        result(HTResponse(response: response.response, request: request, data: data))
                    }
                    
                    // 请求完成后，要把请求从列表中移除
                    self?.removeRequest(identifier: request.identifier)
            })
            
            self.addRequest(request: request, netRequest: dataRequest)
            
        } catch let error as HTNetworkError {
            let res = HTResponse(response: nil, request: request, data: nil, error: error)
            res.htError = error
            result(res)
        } catch {
            let res = HTResponse(response: nil, request: request, data: nil, error: error)
            res.htError = HTNetworkError.unknow
            result(res)
        }
    }
    

    /// block形式的下载请求
    func download(request: HTRequest, result: @escaping HTNetworkingCallback, progress: HTNetworkingProgressCallback?) {
        
        // 先判断是否设置了下载地址
        guard let downloadDestination = request.downloadDestination else {
            
            // 这里要加一个错误 返回
            let error = NSError(domain: "下载地址未指定", code: 2011, userInfo: nil)
            result(HTResponse(error: error))
            
            return
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let fileURL = URL(fileURLWithPath: downloadDestination)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        do {
            let url = try request.asURLRequest()
            
            let downloadRequest = Alamofire.download(url, to: destination)
                .response { [weak self] (response) in
                    
                    request.requestStartTime = response.timeline.requestStartTime
                    request.initialResponseTime = response.timeline.initialResponseTime
                    request.requestCompletedTime = response.timeline.requestCompletedTime
                    
                    if let error = response.error {
                        // 请求出错了
                        result(HTResponse(error: error))
                    }
                    else {
                        
                        result(HTResponse(response: response.response, request: request, data: nil, destinationURL: response.destinationURL))
                    }
                    
                    // 请求完成后，要把请求从列表中移除
                    self?.removeRequest(identifier: request.identifier)
                    
                    
                }
                .downloadProgress { (progressValue) in
                    if let progress = progress {
                        progress(progressValue)
                    }
            }
            
            self.addRequest(request: request, netRequest: downloadRequest)
            
        } catch {
            
            // 捕获url构建错误
            result(HTResponse(error: error))
        }
    }
}
