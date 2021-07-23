//
//  HTCipherUtil.h
//  HelloTalk_Binary
//
//  Created by Zz on 10/1/18.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CipherUtil : NSObject

+ (NSData *)xTEAEncryptData:(NSData *)plainData;
+ (NSData *)xTEADecryptData:(NSData *)encryptData;

@end
