//
//  OCExceptionCatch.h
//  HTiOSKit
//
//  Created by brant on 7/3/2019.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCExceptionCatch : NSObject

+ (id)aes128Encrypt:(NSData *)data;
+ (id)aes128Decrypt:(NSData *)data;

+ (id)xTeaEncrypt:(NSData *)data;
+ (id)xTeaDecrypt:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
