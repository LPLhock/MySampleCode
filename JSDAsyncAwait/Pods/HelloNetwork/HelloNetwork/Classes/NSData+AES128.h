//
//  NSData+AES128.h
//  helloTalk
//
//  Created by tcj on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSData (AES128)
- (NSData *)AES128EncryptWithKey:(NSString *)key;
- (NSData *)AES128DecryptWithKey: (NSString *)key;

- (NSData *)AES128EncryptHttpWithKey:(NSString *)key;
- (NSData *)AES128DecryptHttpWithKey: (NSString *)key;
@end
