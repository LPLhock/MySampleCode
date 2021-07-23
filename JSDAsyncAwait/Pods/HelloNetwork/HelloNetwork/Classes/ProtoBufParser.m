//
//  ProtoBufParser.m
//  HTiOSKit
//
//  Created by brant on 21/9/2018.
//

#import "ProtoBufParser.h"


@implementation ProtoBufParser


+ (id)parser:(NSData *)data withType:(Class<GeneratedMessageProtocol>)cls {
    id result = nil;
    
    if (data == nil || cls == nil) {
        return nil;
    }
    
    @try {
        result = [cls parseFromData:data];
    } @catch (NSException *e) {
        NSLog(@"ProtoBufParser pb解析出错了: %@", e);
        return e;
    }
    
    return result;
}

@end
