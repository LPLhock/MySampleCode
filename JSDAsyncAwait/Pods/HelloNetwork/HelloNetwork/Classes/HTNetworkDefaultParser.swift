//
//  HTNetworkDefaultParser.swift
//  HTiOSKit
//
//  Created by brant on 31/8/2018.
//

import Foundation

class HTNetworkDefaultParser: HTNetworkParserProtocol {
    
    
    static func parser(response: HTResponse?, request: HTRequest?, data: Data?) throws -> Any? {
        guard let request = request else {
            return nil
        }
        
        var result: Any?
        
        switch request.responseSerializerType {
        case .json:
            // 将请求结果转为json格式
            guard let d = data else {
                return result
            }
            
            let jsonObj = try String(data: d, encoding: String.Encoding.utf8)?.json()
            result = jsonObj
            break
        case .http:
            // 如果是http类型的，不对结果做处理
            break
        case .pb:
            // 将结果转化为pb格式
//            result = request.pbType?.parse(from: data)
            let parseResult = ProtoBufParser.parser(data, withType: request.pbType)
            if parseResult is NSException {
                throw HTNetworkError.responseDecodeFailed(reason: .pbDecodeFailed)
            } else {
                result = parseResult
            }
           
            break
            
        }
        
        return result
    }
    
    
}
