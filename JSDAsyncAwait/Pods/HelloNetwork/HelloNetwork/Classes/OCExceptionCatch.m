//
//  OCExceptionCatch.m
//  HTiOSKit
//
//  Created by brant on 7/3/2019.
//

#import "OCExceptionCatch.h"
#import "NSData+AES128.h"
#import "CipherUtil.h"

static NSString *const AES128EncodingKey = @"15helloTCJTALK20";

@implementation OCExceptionCatch

+ (id)aes128Encrypt:(NSData *)data {
    @try {
        return [data AES128EncryptWithKey:AES128EncodingKey];
    } @catch (NSException *e) {
        NSLog(@"❌aes128 加密异常❌");
        return e;
    }
}

+ (id)aes128Decrypt:(NSData *)data {
    @try {
        return [data AES128DecryptWithKey:AES128EncodingKey];
    } @catch (NSException *e) {
        NSLog(@"❌aes128 解密异常❌");
        return e;
    }
}

+ (id)xTeaEncrypt:(NSData *)data {
    @try {
        return [CipherUtil xTEAEncryptData:data];
    } @catch (NSException *e) {
        NSLog(@"❌xtea 加密异常❌");
        return e;
    }
}

+ (id)xTeaDecrypt:(NSData *)data {
    @try {
        return [CipherUtil xTEADecryptData:data];
    } @catch (NSException *e) {
        NSLog(@"❌xtea 解密异常❌");
        return e;
    }
}

@end
