//
//  NetworkingProxy.swift
//  RequestDemo
//
//  Created by brant on 2018/7/26.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation
import RxSwift

//extension Notification.Name {
//    /// 跟 HTNetworking 相关的所有通知
//    public struct Network {
//        /// 在请求发出后发送
//        public static let DidStart = Notification.Name(rawValue: "com.hellotalk.notification.name.network.didStart")
//        
//        /// 在请求成功返回后发送
//        public static let DidComplete = Notification.Name(rawValue: "com.hellotalk.notification.name.network.didComplete")
//    }
//}
//
//Notification.Name.Network.DidStart

public enum HTMimeType: String {
    case ccbin = "ht/ccbin"
    case binary = "ht/binary"
    case json = "application/json"
    case pb = "ht/pb"
    case cc2018 = "bin/cc2018"
    case cc2019 = "bin/cc2019"
    case unknow = "unknow"
    
    static func htMimeType(with string: String) -> HTMimeType {
        if (string == HTMimeType.ccbin.rawValue) {
            return .ccbin
        }
        else if (string == HTMimeType.binary.rawValue) {
            return .binary
        }
        else if (string == HTMimeType.json.rawValue) {
            return .json
        }
        else if (string == HTMimeType.pb.rawValue) {
            return .pb
        }
        else if (string == HTMimeType.cc2018.rawValue) {
            return .cc2018
        }
        else if (string == HTMimeType.cc2019.rawValue) {
            return .cc2019
        }
        
        return .unknow
    }
}

// Observable 的事件类型
public enum HTProgressResponse {
    case result(response: HTResponse)
    case progress(progress: Progress)
}

public typealias HTNetworkingCallback = (_ response: HTResponse) -> ()

// 进度回调
public typealias HTNetworkingProgressCallback = (_ progress: Progress) -> ()


/// 网络代理类，负责接收request，分发给对应的网络实现
public class HTNetworkingProxy {
    
    public static let shared = HTNetworkingProxy()
    var networkings: Dictionary<String, HTNetworkingProtocol> = [:]
    
    /// 数据解析 从外部赋值
    public var parser: HTNetworkParserProtocol.Type?
    /// 数据解压解密 从外部赋值
    public var decoder: HTNetworkDecodeProtocol.Type?
    
    /// 出错时候的全局回调
    public var onError: ((_ error: HTNetworkError?, _ request: HTRequest, _ response: HTResponse) -> ())?
    
    /// 注册一个网络实现
    ///
    /// - Parameter networking: 网络实现
    open func registerNetworking(networking: HTNetworkingProtocol) {
        networkings[networking.typeName] = networking
    }
    
    init() {
        registerNetworking(networking: HTNetworking())
        
        parser = HTNetworkDefaultParser.self
        decoder = HTNetworkDefaultDecoder.self
    }
    
    /// 发送一个Http 下载请求，返回一个可观察的 response
    ///
    /// - Parameter request: 请求的参数
    /// - Returns: Observable
    func download(request: HTRequest) -> Observable<HTProgressResponse>? {
        // 拿出request里面的类型
        let type = request.networkingType
        // 拿到对应的网络实现
        let networking = networkings[type]
        
        assert(networking != nil, "不存在的 networkingType")
        
        return networking!.download(request: request)
    }
    
    /// 发送一个Http请求，返回一个可观察的 response
    ///
    /// - Parameter request: 请求的参数
    /// - Returns: Observable
    func send(request: HTRequest) -> Observable<HTResponse> {
        // 拿出request里面的类型
        let type = request.networkingType
        // 拿到对应的网络实现
        let networking = networkings[type]
        
        assert(networking != nil, "不存在的 networkingType")
        
        let observable = networking!.send(request: request).observeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).map({[weak self] (result) -> HTResponse in
            
            do {
                let response = result
                
                // 如果请求成功，要对数据进行解密操作
                let data = try self?.decoder?.decode(response: response.response, data: response.data)
                response.decryptedData = data
                request.decryptEndTime = CFAbsoluteTimeGetCurrent()
                
                // 解密成功后，对数据进行Json解析
                let object = try self?.parser?.parser(response: response, request: response.request, data: data)
                response.parserObject = object
                
                request.parseEndTime = CFAbsoluteTimeGetCurrent()
                
                // 对解析好的数据调用convert方法，让接口解析成对应的对象。
                response.object = response.request?.convert(response: response)
                request.convertEndTime = CFAbsoluteTimeGetCurrent()
                
                return response
            } catch let error as HTNetworkError {
                let response = result
                response.htError = error
                self?.onError?(error, request, response)
                return response
            } catch {
                let response = result
                response.htError = HTNetworkError.unknow
                self?.onError?(HTNetworkError.unknow, request, response)
                return response
            }
        })
        
        return observable
    }
    
    
    /// 通过request来取消请求
    ///
    /// - Parameter request:
    func cancel(request: HTRequest) {
        // 拿出request里面的类型
        let type = request.networkingType
        // 拿到对应的网络实现
        let networking = networkings[type]
        
        guard let network = networking else {
            return
        }
        
        network.cancel(identifier: request.identifier)
    }
}

extension HTNetworkingProxy {
    func send(request: HTRequest, result: @escaping HTNetworkingCallback) {
        // 拿出request里面的类型
        let type = request.networkingType
        // 拿到对应的网络实现
        let networking = networkings[type]
        
        assert(networking != nil, "不存在的 networkingType")
        
        networking?.send(request: request, result: { [weak self] (response) in
            
            do {
                if (response.error == nil) {
                    // 如果请求成功，要对数据进行解密操作
                    // 如果请求成功，要对数据进行解密操作
                    let data = try self?.decoder?.decode(response: response.response, data: response.data)
                    response.decryptedData = data
                    request.decryptEndTime = CFAbsoluteTimeGetCurrent()
                    
                    // 解密成功后，对数据进行Json解析
                    let object = try self?.parser?.parser(response: response, request: response.request, data: data)
                    response.parserObject = object
                    request.parseEndTime = CFAbsoluteTimeGetCurrent()
                    
                    // 对解析好的数据调用convert方法，让接口解析成对应的对象。
                    response.object = response.request?.convert(response: response)
                    request.convertEndTime = CFAbsoluteTimeGetCurrent()
                }
                
                result(response)
            } catch let error as HTNetworkError {
                response.htError = error
                self?.onError?(error, request, response)
                result(response)
            } catch {
                response.htError = HTNetworkError.unknow
                self?.onError?(HTNetworkError.unknow, request, response)
                result(response)
            }
        })
    }
    
    func download(request: HTRequest, result: @escaping HTNetworkingCallback, progress: HTNetworkingProgressCallback?) {
        // 拿出request里面的类型
        let type = request.networkingType
        // 拿到对应的网络实现
        let networking = networkings[type]
        
        assert(networking != nil, "不存在的 networkingType")
        
        networking?.download(request: request, result: result, progress: progress)
    }
}
