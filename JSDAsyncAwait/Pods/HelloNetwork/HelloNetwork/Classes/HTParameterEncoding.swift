//
//  HTParameterEncoding.swift
//  RequestDemo
//
//  Created by brant on 7/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation
import Alamofire

// 这个参数编码会对参数进行aes128加密处理
public struct AES128Encoding: ParameterEncoding {
    
    static let encodeKey = "15helloTCJTALK20"
    
    // MARK: Properties
    
    /// Returns a `AES128Encoding` instance with default writing options.
    public static var `default`: AES128Encoding { return AES128Encoding() }
    
    /// Returns a `AES128Encoding` instance with `.prettyPrinted` writing options.
    public static var prettyPrinted: AES128Encoding { return AES128Encoding(options: .prettyPrinted) }
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    // MARK: Initialization
    
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    // MARK: Encoding
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            let result = OCExceptionCatch.aes128Encrypt(data)
            if result is NSException {
                throw HTNetworkError.parameterEncodingFailed(reason: .aes128EncryptFailed)
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("ht/ccbin", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = result as? Data
        } catch {
            throw HTNetworkError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
    
    
    public func encode(_ urlRequest: URLRequestConvertible, withData originalData: Data? = nil) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let originalData = originalData else { return urlRequest }
        
        let data = originalData
        
        let result = OCExceptionCatch.aes128Encrypt(data)
        if result is NSException {
            throw HTNetworkError.parameterEncodingFailed(reason: .aes128EncryptFailed)
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("ht/ccbin", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = result as? Data
        
        return urlRequest
    }
}

// 这个参数编码会对参数进行xxtea加密处理
public struct XXTEAEncoding: ParameterEncoding {
    
    // MARK: Properties
    
    /// Returns a `XXTEAEncoding` instance with default writing options.
    public static var `default`: XXTEAEncoding { return XXTEAEncoding() }
    
    /// Returns a `XXTEAEncoding` instance with `.prettyPrinted` writing options.
    public static var prettyPrinted: XXTEAEncoding { return XXTEAEncoding(options: .prettyPrinted) }
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    // MARK: Initialization
    
    /// Creates a `XXTEAEncoding` instance using the specified options.
    ///
    /// - parameter options: The options for writing the parameters as JSON data.
    ///
    /// - returns: The new `XXTEAEncoding` instance.
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    // MARK: Encoding
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            let result = OCExceptionCatch.xTeaEncrypt(data)
            if result is NSException {
                throw HTNetworkError.parameterEncodingFailed(reason: .xteaEncryptFailed)
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("ht/ccbin", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = result as? Data
        } catch {
            throw HTNetworkError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
    
    
    public func encode(_ urlRequest: URLRequestConvertible, withData originalData: Data? = nil) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let originalData = originalData else { return urlRequest }
        
        let data = originalData
        
        let result = OCExceptionCatch.xTeaEncrypt(data)
        if result is NSException {
            throw HTNetworkError.parameterEncodingFailed(reason: .xteaEncryptFailed)
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("ht/ccbin", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = result as? Data
        
        return urlRequest
    }
}
