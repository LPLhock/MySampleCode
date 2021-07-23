//
//  HTNetworkDefaultDecoder.swift
//  HTiOSKit
//
//  Created by brant on 31/8/2018.
//

import Foundation
import DataCompression


/// 默认的数据解密解压类
class HTNetworkDefaultDecoder: HTNetworkDecodeProtocol {
    
    static let decodeKey = "15helloTCJTALK20"
    
    static func decode(response: URLResponse?, data: Data?) throws -> Data? {
        guard let mimeType = response?.mimeType else {
            return nil
        }
        
        guard let data = data else {
            return nil
        }
        
        var decodeData: Data? = data
        let type = HTMimeType.htMimeType(with: mimeType)
        switch type {
            
        case .ccbin:
            /// ht/ccbin 要先解密 再gzip解压
            let zipData = OCExceptionCatch.aes128Decrypt(data)
            if zipData is NSException {
                // 解密失败
                throw HTNetworkError.responseDecodeFailed(reason: .aes128DecodeFailed)
            }
            
            // 再解压
            if let unzipData = (zipData as? Data)?.gunzip() {
                decodeData = unzipData
            } else {
                print("数据解压失败")
                throw HTNetworkError.responseDecodeFailed(reason: .ungzipFailed)
            }
            
            break
            
        case .binary:
            /// ht/binary AES解密
            let result = OCExceptionCatch.aes128Decrypt(data)
            if result is NSException {
                throw HTNetworkError.responseDecodeFailed(reason: .aes128DecodeFailed)
            } else {
                decodeData = result as? Data
            }
            
            break
            
        case .unknow:
            
            break
            
        case .json:
            
            break
            
        case .pb:
            
            break
            
        case .cc2018:
            // TEA解密
            let result = OCExceptionCatch.xTeaDecrypt(data)
            if result is NSException {
                throw HTNetworkError.responseDecodeFailed(reason: .xteaDecodeFailed)
            } else {
                decodeData = result as? Data
            }
            
            break;

        case .cc2019:
            // TEA解密
            let result = OCExceptionCatch.xTeaDecrypt(data)
            if result is NSException {
                throw HTNetworkError.responseDecodeFailed(reason: .xteaDecodeFailed)
            } else {
                decodeData = result as? Data
                
                // 再解压
                if let unzipData = (decodeData)?.gunzip() {
                    decodeData = unzipData
                } else {
                    print("数据解压失败")
                    throw HTNetworkError.responseDecodeFailed(reason: .ungzipFailed)
                }
                
            }
            
            break;
        }
        
        return decodeData
    }
    
    
}
