//
//  HTCipherUtil.m
//  HelloTalk_Binary
//
//  Created by Zz on 10/1/18.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "CipherUtil.h"
#import "XXTEAUtility.h"
#import "Utils.h"

#define MaxBufferSize       1024 * 64 * 2
#define CLIENT_RANDKEY_LEN  16

@implementation CipherUtil

+ (NSData *)xTEAEncryptData:(NSData *)plainData {
    NSString *randomStr = [Utils createRandomString:CLIENT_RANDKEY_LEN];
    const char *randomChar = [randomStr cStringUsingEncoding:NSUTF8StringEncoding];
    char kDefaultRandKey[16] = {0};
    memccpy(kDefaultRandKey, randomChar, sizeof(char), CLIENT_RANDKEY_LEN);
    
    char szEncrytText[MaxBufferSize] = { 0 };
    unsigned int nEncryptLen = MaxBufferSize;
    if (!xTEAEncryptWithKey((const char*)[plainData bytes], (unsigned int)[plainData length],
                            kDefaultRandKey, szEncrytText, &nEncryptLen)) {
//        HTDDLogError(@"WNS:P2P数据加密出错!!!");
        return nil;
    }
    
    NSMutableData *encryptData = [NSMutableData data];
    [encryptData appendBytes:kDefaultRandKey length:CLIENT_RANDKEY_LEN];
    [encryptData appendBytes:szEncrytText length:nEncryptLen];
    
    return encryptData;
}

+ (NSData *)xTEADecryptData:(NSData *)encryptData {
    if (encryptData.length == 0) {
        return nil;
    }
    
    char szKey[CLIENT_RANDKEY_LEN] = { 0 };
    [encryptData getBytes:szKey range:NSMakeRange(0, CLIENT_RANDKEY_LEN)];
    char* pEncrytData = (char*)encryptData.bytes + CLIENT_RANDKEY_LEN;
    unsigned int nEncrytLen = (unsigned int)encryptData.length - CLIENT_RANDKEY_LEN;

    char szPlainText[MaxBufferSize] = { 0 };
    unsigned int nPlianLen = MaxBufferSize;
    if (!xTEADecryptWithKey(pEncrytData, nEncrytLen, szKey, szPlainText, &nPlianLen)) {
//        HTDDLogError(@"WNS:Rand key数据解密出错!!!");
        return nil;
    }
    NSData *data = [NSData dataWithBytes:szPlainText length:nPlianLen];
    return data;
}


@end
