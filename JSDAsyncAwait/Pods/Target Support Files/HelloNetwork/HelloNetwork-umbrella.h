#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CipherUtil.h"
#import "NSData+AES128.h"
#import "OCExceptionCatch.h"
#import "ProtoBufParser.h"
#import "Utils.h"
#import "XXTEAUtility.h"

FOUNDATION_EXPORT double HelloNetworkVersionNumber;
FOUNDATION_EXPORT const unsigned char HelloNetworkVersionString[];

