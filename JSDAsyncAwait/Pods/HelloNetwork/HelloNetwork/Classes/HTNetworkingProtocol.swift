//
//  NetworkingProtocol.swift
//  RequestDemo
//
//  Created by brant on 2018/7/26.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation
import RxSwift

/// 具体的网络实现要实现这个接口，用来注册到网络代理中去
public protocol HTNetworkingProtocol {
    
    // 网络类型  wns http等
    var typeName: String { get }
    
    // 下载任务，带有进度回调
    func download(request: HTRequest) -> Observable<HTProgressResponse>?
    func download(request: HTRequest, result: @escaping HTNetworkingCallback, progress: HTNetworkingProgressCallback?)
    
    func send(request: HTRequest) -> Observable<HTResponse>
    func send(request: HTRequest, result: @escaping HTNetworkingCallback)
    
    func cancel(identifier: String)
}

