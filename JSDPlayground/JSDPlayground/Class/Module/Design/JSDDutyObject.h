//
//  JSDDutyObject.h
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSDDutyObject;
NS_ASSUME_NONNULL_BEGIN

typedef void(^completionBlock)(BOOL handle);
typedef void(^resultBlock)(JSDDutyObject* object, BOOL handle);

@interface JSDDutyObject : NSObject

@property (nonatomic, strong) JSDDutyObject* nextObject;

- (void)handle:(resultBlock)resultBlock;
- (void)handleDutyObject:(completionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
