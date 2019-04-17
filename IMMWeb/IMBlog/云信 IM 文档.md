# 云信 IM 文档

[云信](https://dev.yunxin.163.com/docs/product/IM%E5%8D%B3%E6%97%B6%E9%80%9A%E8%AE%AF/%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D/%E4%B8%BB%E8%A6%81%E5%8A%9F%E8%83%BD)
[toc]

## 个人账户管理

### 注册接口

注册提供手机号 是否需要提供加密. 加密方式。  
以及用户设置的密码 加密方式.

**服务端: 后台**

### 用户个人信息更新 包括 YOLO 号 和其他编辑信息等

两个接口, 一个针对 YOLO 一个针对个人信息编辑。
**服务端: 后台**

### 获取用户名片(个人信息)

参考资料: 

**服务端: 网易**

### 登录 账号及密码.

加密.
自动登录流程. 
后台如何存储.
如果将用户账号和密码直接存储在本地,安全问题.

**服务端: 后台**

## 创建群组 返回参数说明

```
/**
 *  创建群组block
 *
 *  @param error   错误,如果成功则error为nil
 *  @param teamId  群组ID
 *  @param failedUserIds 邀请失败的群成员ID
 */
typedef void(^NIMTeamCreateHandler)(NSError * __nullable error, NSString * __nullable teamId, NSArray<NSString *> * __nullable failedUserIds);
/**
 *  创建群组
 *
 *  @param option     创建群选项
 *  @param users      用户ID列表
 *  @param completion 完成后的回调
 */
- (void)createTeam:(NIMCreateTeamOption *)option
              users:(NSArray<NSString *> *)users
         completion:(nullable NIMTeamCreateHandler)completion;
```
创建群组需要 users ID 数组,账号. NIMCreateTeamOption 群选项, 可以做相关配置.



