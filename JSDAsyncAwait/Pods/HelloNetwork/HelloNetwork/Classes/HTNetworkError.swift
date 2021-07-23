//
//  HTNetworkError.swift
//  RequestDemo
//
//  Created by brant on 8/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation
import Alamofire

public enum HTNetworkError: Error {
    case unknow                 // 未知错误
    case invalidURL(url: String?)   // url错误
    case netError               // 网络错误
    case timeout                // 网络超时
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)    // 参数编码、加密错误
    case responseDecodeFailed(reason: ResponseDecodeFailureReason)          // 结果解码错误
    
    public enum ParameterEncodingFailureReason {
        case missingURL
        case aes128EncryptFailed    // aes128加密失败
        case xteaEncryptFailed      // xtea加密失败
        case jsonEncodingFailed(error: Error?)     // json格式化失败
    }
    
    public enum ResponseDecodeFailureReason {
        case jsonDecodeFailed(error: Error?)   // json解析失败
        case pbDecodeFailed     // pb解析失败
        case aes128DecodeFailed // aes128解密失败
        case xteaDecodeFailed   // xtea解密失败
        case ungzipFailed           // gzip 解压失败
    }
}

extension HTNetworkError {
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
    
    public var isNetError: Bool {
        if case .netError = self { return true }
        return false
    }
    
    public var isTimeoutError: Bool {
        if case .timeout = self { return true }
        return false
    }
    
    public var isParameterEncodingFailedError: Bool {
        if case .parameterEncodingFailed = self { return true }
        return false
    }
    
    public var isResponseDecodeFailedError: Bool {
        if case .responseDecodeFailed = self { return true }
        return false
    }
    
    public var isUnknowError: Bool {
        if case .unknow = self { return true }
        return false
    }
}

extension HTNetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknow:
            return "HTNetwork: unknow error"
        case .invalidURL(let url):
            return "HTNetwork: URL is not valid: \(url ?? "")"
        case .netError:
            return "HTNetwork: Network error"
        case .timeout:
            return "HTNetwork: request timeout"
        case .parameterEncodingFailed(let reason):
            return reason.localizedDescription
        case .responseDecodeFailed(let reason):
            return reason.localizedDescription
        }
    }
}

extension HTNetworkError.ParameterEncodingFailureReason {
    public var localizedDescription: String {
        switch self {
        case .aes128EncryptFailed:
            return "HTNetwork: aes128 encrypt error"
        case .jsonEncodingFailed(let error):
            return "HTNetwork: JSON encoding error: \(error?.localizedDescription ?? "")"
        case .missingURL:
            return "HTNetwork: url is nil"
        case .xteaEncryptFailed:
            return "HTNetwork: xtea encrypt error"
        }
    }
}

extension HTNetworkError.ResponseDecodeFailureReason {
    public var localizedDescription: String {
        switch self {
        case .aes128DecodeFailed:
            return "HTNetwork: aes128 decrypt error"
        case .jsonDecodeFailed(let error):
            return "HTNetwork: JSON decoding error: \(error?.localizedDescription ?? "")"
        case .pbDecodeFailed:
            return "HTNetwork: protobuf decode error"
        case .ungzipFailed:
            return "HTNetwork: ungzip error"
        case .xteaDecodeFailed:
            return "HTNetwork: xtea decode error"
        }
    }
}
