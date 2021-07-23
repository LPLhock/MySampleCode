//
//  HTNetworkParserProtocol.swift
//  Pods
//
//  Created by brant on 28/8/2018.
//

import Foundation


/// 数据解析协议
public protocol HTNetworkParserProtocol {
    
    static func parser(response: HTResponse?, request: HTRequest?, data: Data?) throws -> Any?
}
