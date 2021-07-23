//
//  UserFollowInfoApi.swift
//  HelloTalk_Binary
//
//  Created by brant on 9/8/2018.
//  Copyright © 2018 HT. All rights reserved.
//

import UIKit
import HelloNetwork

/*
 读取指定用户的粉丝数和关注数
 */
@objc class UserFollowInfoApi: HTRequest {
    
    var userId: UInt32
    
    @objc init(userId: UInt32) {
        
        self.userId = userId
        super.init()
        
    }
    
    override var host: String {
        return "https://uploadpro.hellotalk8.com"
    }
    
    override var path: String {
        return "/graphql/user_info_cache"
    }
    
    override var parameters: Dictionary<String, Any> {
        return ["query": "{user(uids:[\(userId)]){following_cnt,follower_cnt}}"]
    }
    
    override func convert(response: HTResponse) -> Any? {
        
        
        var followInfoModel: FollowInfoModel? = nil
        if let data = response.data {
            followInfoModel = try? JSONDecoder().decode(FollowInfoModel.self, from: data)
        }
//        guard let json = (response.parserObject as? Dictionary<String, Any>) else {
//            return nil
//        }
//
//        guard let data = (json["data"] as? Dictionary<String, Any>) else {
//            return nil
//        }
//
//        guard let users = (data["user"] as? Array<Any>) else {
//            return nil
//        }
//
//        if (users.count > 0) {
////            followInfoModel = HTFollowInfoModel(dictionary: users[0] as! Dictionary<AnyHashable, Any>)
//            followInfoModel =
//        }
        
        return followInfoModel
    }
}

struct FollowInfoModel: Codable {
    
    let following: UInt32?
    let follower: UInt32?
    
    enum CodingKeys: String, CodingKey {
        case following = "follower_cnt"
        case follower = "following_cnt"
    }
}
