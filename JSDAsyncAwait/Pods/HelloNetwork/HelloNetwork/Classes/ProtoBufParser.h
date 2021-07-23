//
//  ProtoBufParser.h
//  HTiOSKit
//
//  Created by brant on 21/9/2018.
//

#import <Foundation/Foundation.h>
#import <ProtocolBuffers/ProtocolBuffers.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProtoBufParser : NSObject

+ (id)parser:(nullable NSData *)data withType:(nullable Class<GeneratedMessageProtocol>)cls;

@end

NS_ASSUME_NONNULL_END
