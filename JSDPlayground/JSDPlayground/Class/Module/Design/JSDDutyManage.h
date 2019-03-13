//
//  JSDDutyManage.h
//  JSDPlayground
//
//  Created by Jersey on 2019/3/13.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSDDutyObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDDutyManage : NSObject

- (void)start;
- (instancetype)initWithFirestObject:(JSDDutyObject* )object;

@end

NS_ASSUME_NONNULL_END
