//
//  NSObject+JSDPerformSelector.h
//  JSDPlayground
//
//  Created by Jersey on 2019/1/12.
//  Copyright © 2019年 Jersey. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JSDPerformSelector)

- (id)jsd_performSelector:(SEL)aSelector withObjects:(NSArray*)objects;

@end

NS_ASSUME_NONNULL_END
