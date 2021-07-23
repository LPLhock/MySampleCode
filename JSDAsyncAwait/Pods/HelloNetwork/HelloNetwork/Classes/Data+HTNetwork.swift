//
//  Data+HTNetwork.swift
//  RequestDemo
//
//  Created by brant on 5/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation

extension Data {
   
    // 将Data转化为Json object
    public var jsonValue: Any? {
        
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions.mutableContainers)
            return json
            
        } catch let error {
            
            print("Json 解析出错")
            print(error)
            return nil
        }
    }
}
