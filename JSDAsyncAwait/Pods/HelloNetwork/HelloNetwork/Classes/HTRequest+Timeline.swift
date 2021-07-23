//
//  HTRequest+Timeline.swift
//  RequestDemo
//
//  Created by brant on 6/8/2018.
//  Copyright © 2018 brant. All rights reserved.
//

import Foundation

extension HTRequest {
    
    /// 生成timeline 对象
    public var timeline: HTNetworkTimeline {
        return HTNetworkTimeline(requestStartTime: self.requestStartTime,
                                 initialResponseTime: self.initialResponseTime,
                                 requestCompletedTime: self.requestCompletedTime,
                                 decryptEndTime: self.decryptEndTime,
                                 parseEndTime: self.parseEndTime,
                                 convertEndTime: self.convertEndTime)
    }
    
    /// 返回请求的时间描述
    public func requestTimeDescription() -> String {
        do {
            let desc = try "== [url: \(String(describing: self.asURLRequest().url?.absoluteString))] time: \(self.timeline.logDescription()) =="
            return desc
        } catch {
            return ""
        }
    }
}
