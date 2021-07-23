//
//  String+HTNetwork.swift
//  RequestDemo
//
//  Created by brant on 1/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation

extension String {
    
    /// 转化为json object
    public func jsonValue() -> Any? {
        
        if (self.count <= 0) {
            return nil
        }
        
        do {
            guard let data = self.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return json
            
        } catch let error {
            
            print("Json 解析出错")
            print(error)
            return nil
        }
    }
    
    public func json() throws -> Any? {
        if self.count <= 0 {
            return nil
        }
        
        guard let data = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return json
        } catch let error {
            throw HTNetworkError.responseDecodeFailed(reason: .jsonDecodeFailed(error: error))
        }
    }
}
