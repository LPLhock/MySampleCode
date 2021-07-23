//
//  HTNetworkDecryptionProtocol.swift
//  HTiOSKit
//
//  Created by brant on 28/8/2018.
//

import Foundation


/// 数据加解密协议
public protocol HTNetworkDecodeProtocol {
    
    static func decode(response: URLResponse?, data: Data?) throws -> Data?
}
