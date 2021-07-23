//
//  HTNetworkTimeline.swift
//  RequestDemo
//
//  Created by brant on 6/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation

/// 记录请求、响应以及数据解析的时间
public struct HTNetworkTimeline {
    
    /// 请求开始的时间
    public let requestStartTime: CFAbsoluteTime
    
    /// 开始接收服务器返回数据的时间
    public let initialResponseTime: CFAbsoluteTime
    
    /// 请求完成的时间
    public let requestCompletedTime: CFAbsoluteTime
    
    /// 解密解压完成时间
    public let decryptEndTime: CFAbsoluteTime
    
    /// 转完json时间
    public let parseEndTime: CFAbsoluteTime
    
    /// convert 方法完成时间
    public let convertEndTime: CFAbsoluteTime
    
    /// 解密时间
    public let decryptTime: TimeInterval
    /// 转json时间
    public let parseTime: TimeInterval
    /// convert 方法耗时
    public let convertTime: TimeInterval
    /// 请求时间，从开始请求到请求完成
    public let requestTime: TimeInterval
    /// 数据传输时间  从开始接收数据到数据全部接收完成的时间
    public let responseTime: TimeInterval
    
    public init(requestStartTime: CFAbsoluteTime,
                initialResponseTime: CFAbsoluteTime,
                requestCompletedTime: CFAbsoluteTime,
                decryptEndTime: CFAbsoluteTime,
                parseEndTime: CFAbsoluteTime,
                convertEndTime: CFAbsoluteTime) {
        self.requestStartTime = requestStartTime
        self.initialResponseTime = initialResponseTime
        self.requestCompletedTime = requestCompletedTime
        self.decryptEndTime = decryptEndTime
        self.parseEndTime = parseEndTime
        self.convertEndTime = convertEndTime
        
        self.decryptTime = decryptEndTime - requestCompletedTime
        self.parseTime = parseEndTime - decryptEndTime
        self.convertTime = convertEndTime - parseEndTime
        self.requestTime = requestCompletedTime - requestStartTime
        self.responseTime = requestCompletedTime - initialResponseTime
    }
    
    // 用来打印log
    func logDescription() -> String {
        return "[请求时间:\(self.requestTime) \n响应时间:\(self.responseTime) \n解密时间:\(self.decryptTime) \nJSON转化时间:\(self.parseTime) \nconvert方法时间:\(self.convertTime)]"
    }
}
