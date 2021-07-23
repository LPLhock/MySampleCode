//
//  HTNetworkConfig.swift
//  RequestDemo
//
//  Created by brant on 8/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation

/// HTRequest的默认配置
public class HTNetworkConfig {
    
    public static let shared: HTNetworkConfig = HTNetworkConfig()
    
    /// 默认的请求头，在发起请求的时候会带上，如果定制的请求头里有相同字段，默认的会被覆盖
    open var defaultHeaders: Dictionary<String, String>? {
        return [
            "Content-Encoding": "gzip",
            "httpdns_protocol": "httpdns",
            "User-Agent": userAgent ?? ""
        ]
    }
    
    /// 默认的请求url,不包含path，最后不用加斜杠 例如：http://www.example.com
    open var requestUrl: String? = nil
    
    /// 默认的User-Agent
    open var userAgent: String? = "ios;"
}
