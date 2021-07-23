//
//  HTResponse.swift
//  RequestDemo
//
//  Created by brant on 2018/7/19.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation



/// http 的response对象 
@objc public class HTResponse: NSObject {
    
    @objc public let request: HTRequest?
    
    /// The server's response to the URL request.
    @objc public let response: URLResponse?
    
    /// The data returned by the server.
    @objc public let data: Data?
    
    /// 下载文件的路径 
    @objc public let destinationURL: URL?
    
    /// The error encountered while executing or validating the request.
    @objc public let error: Error?
    public var htError: HTNetworkError?
    
    /// The timeline of the complete lifecycle of the request.
//    public let timeline: Timeline
    
    /// 解密解压后的data, 如果是未加密数据，就和上面的data一样
    @objc public var decryptedData: Data?
    
    /// request里面，convert 方法返回的对象
    @objc public var object: Any?
    
    /// 解析后的对象，可能是json,也可能是pb
    @objc public var parserObject: Any?
    
    public init(response: URLResponse? = nil, request: HTRequest? = nil, data: Data? = nil, error: Error? = nil, destinationURL: URL? = nil) {
        self.request = request
        self.response = response
        self.error = error
        self.data = data
        self.destinationURL = destinationURL
    }
}
