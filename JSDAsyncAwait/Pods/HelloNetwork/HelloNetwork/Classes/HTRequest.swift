//
//  RequestProtocol.swift
//  RequestDemo
//
//  Created by brant on 2018/7/19.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import ProtocolBuffers

/// 请求的数据处理方式
/// 指定了请求数据处理方式后，会自动对post数据进行相关操作
public enum HTRequestSerializerType {
    case http       // 请求数据不做特殊处理
    case json       // 请求数据格式为json
    case aes128     // 请求数据要进行 aes128 加密
    case xxTEA      // 请求数据要进行 xxtea 加密
}

/// 返回数据格式
public enum HTResponseSerializerType {
    case http       /// 返回数据不做任何处理
    case json       /// 返回数据解析为json对象
    case pb         /// 返回数据解析为pb对象
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
    case delete = "DELETE"
}

// 请求的协议
open class HTRequest: NSObject {
    
    /// 1、如果子类重写，会使用子类返回的host，这个host要包含scheme
    /// 例如：https://qtest.hellotalk.com
    ///
    /// 2、如果子类不重写，会使用HTNetworkConfig里面设置的全局requestUrl
    ///
    /// 3、如果以上两种都没有指定，则返回一个空字符串
    open var host: String {
        // 看配置里面是否有设置的默认url
        guard let url = HTNetworkConfig.shared.requestUrl else {
            return ""
        }
        
        return url
    }
    
    /// 请求地址 e.g: /moment/detail
    /// 子类一定要重写这个变量
    open var path: String {
        return ""
    }
    
    /// http请求头
    /// 这里主要用来设置接口特有的http请求头，统一的http请求头会配置在HTNetworkConfig里面
    /// 最终 HTNetworkConfig 和这个 headers都会加到http的请求头里面去
    open var headers: Dictionary<String, String>? {
        return nil
    }
    
    /// Http method e.g: GET,POST
    open var method: HttpMethod {
        return .post
    }
    
    /// request content type
    /// 指定接口的contentType，默认为 application/json
    open var contentType: String? {
        return "application/json"
    }
    
    /// http请求头里面的 user agent
    /// 如果不指定，会使用HTNetworkConfig里面的全局设置
    /// 可以用来定制接口特定的ua
    open var userAgent: String? {
        guard let ua = HTNetworkConfig.shared.userAgent else {
            return nil
        }
        
        return ua
    }
    
    /// 请求参数
    /// 当method为get时   此参数指定请求参数
    ///
    /// 当method为post时
    /// 1、如果postData字段没有值，则使用这个parameters做为post数据
    /// 2、如果postData字段有值时，会忽略parameters
    open var parameters: Dictionary<String, Any> {
        return [:]
    }
    
    /// 指定发送网络请求的库
    /// 目前有两个可选值
    /// 1、HTNetworking 直接发送请求
    /// 2、wns 使用维纳斯发起请求
    /// 这个字段不用在最终的接口类中重定，会有一个base来通过维纳斯配置指定
    open var networkingType: String {
        return "HTNetworking"
    }
    
    /// 唯一标识请求，用来取消请求
    open var identifier: String = ""
    
    /// post的数据
    /// 如果未指定post数据，会使用parameters,如果指定了postData，那么会忽略parameters
    ///
    /// post的httpBody,如： pb请求的body
    open var postData: Data? {
        return nil
    }
    
    /// 请求的数据格式
    open var requestSerializerType: HTRequestSerializerType {
        return .json
    }
    
    /// 默认返回数据解析为json
    open var responseSerializerType: HTResponseSerializerType {
        return .json
    }
    
    /// 如果是pb请求要指定一个pb解析的类型
    open var pbType: GeneratedMessageProtocol.Type? {
        return nil
    }
    
    /// 超时时间
    open var timeout: TimeInterval {
        return 10
    }
    
    /* 下载任务 */
    // 下载文件的存放路径
    open var downloadDestination: String? {
        return nil
    }
    
    open var shouldHandleCookies: Bool {
        return false
    }
    
    // 请求时间相关
    /// 请求开始的时间
    public var requestStartTime: CFAbsoluteTime = 0
    /// 开始接收服务器返回数据的时间
    public var initialResponseTime: CFAbsoluteTime = 0
    
    /// 请求完成的时间
    public var requestCompletedTime: CFAbsoluteTime = 0
    
    /// 解密解压完成时间
    public var decryptEndTime: CFAbsoluteTime = 0
    
    /// 转完json时间
    public var parseEndTime: CFAbsoluteTime = 0
    
    /// convert 方法完成时间
    public var convertEndTime: CFAbsoluteTime = 0
    
    
    /// 数据解析方法
    open func convert(response: HTResponse) -> Any? {
        return response.decryptedData
    }
    
    /// 取消请求
    @objc public func cancel() {
        HTNetworkingProxy.shared.cancel(request: self)
    }
    
    /// 转换成 URLRequest
    open func asURLRequest() throws -> URLRequest {
        let urlString = "\(self.host)\(self.path)"
        
        guard let url = URL(string: urlString) else {
            throw HTNetworkError.invalidURL(url: urlString)
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpShouldHandleCookies = self.shouldHandleCookies
        
        // 设置超时时间
        urlRequest.timeoutInterval = self.timeout
        
        // 设置请求方式
        urlRequest.httpMethod = self.method.rawValue
        
        /// 设置全局的默认header
        if let headers = HTNetworkConfig.shared.defaultHeaders {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // 设置HttpHeader
        if let headers = self.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // 判断是否有UA
        if let ua = self.userAgent {
            urlRequest.setValue(ua, forHTTPHeaderField: "User-Agent")
        }
        
        // content type
        if let contentType = self.contentType {
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        // 设置请求的数据
        switch self.requestSerializerType {
        case .http:
            if (self.postData != nil) {
                urlRequest.httpBody = self.postData
            }
            else {
                do {
                    try urlRequest = URLEncoding.default.encode(urlRequest, with: self.parameters)
                } catch AFError.parameterEncodingFailed(reason: .missingURL) {
                    throw HTNetworkError.parameterEncodingFailed(reason: .missingURL)
                }
            }
            
            break
        case .json:
            do {
                try urlRequest = JSONEncoding.default.encode(urlRequest, with: self.parameters)
            } catch let error as AFError {
                if error.isParameterEncodingError {
                    throw HTNetworkError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error.underlyingError))
                }
            }
            break
        case .aes128:
            
            if (self.postData != nil) {
                try urlRequest = AES128Encoding.default.encode(urlRequest, withData: self.postData)
            }
            else {
                try urlRequest = AES128Encoding.default.encode(urlRequest, with: self.parameters)
            }
            
            break
        case .xxTEA:
            if (self.postData != nil) {
                try urlRequest = XXTEAEncoding.default.encode(urlRequest, withData: self.postData)
            }
            else {
                try urlRequest = XXTEAEncoding.default.encode(urlRequest, with: self.parameters)
            }
            
            break
        }
        
        return urlRequest
    }
}

// MARK: - 发起请求的方法

extension HTRequest {
    
    /// 发送网络请求
    ///
    /// - Returns: Observable
    public func start() -> Observable<HTResponse> {
        return HTNetworkingProxy.shared.send(request: self)
    }
    
    /// 发送下载请求
    ///
    /// - Returns: Observable
    public func download() -> Observable<HTProgressResponse>? {
        return HTNetworkingProxy.shared.download(request: self)
    }
    
    /// oc里面识别不了RxSwift,添加一个block的回调方法给oc
    ///
    /// - Parameter callback: 回调block
    @objc public func start(callback: @escaping HTNetworkingCallback) {
        
        HTNetworkingProxy.shared.send(request: self, result: callback)
        
    }
    
    /// 支持oc的下载任务
    ///
    /// - Parameters:
    ///   - request: request
    ///   - result: 结果回调
    ///   - progress: 进度回调
    @objc public func download(callback: @escaping HTNetworkingCallback, progress: HTNetworkingProgressCallback?) {
        HTNetworkingProxy.shared.download(request: self, result: callback, progress: progress)
    }
}
