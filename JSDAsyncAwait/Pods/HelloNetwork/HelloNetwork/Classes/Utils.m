//
//  Utils.m
//  HTiOSKit
//
//  Created by brant on 31/8/2018.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)createRandomString:(int)len {
    
    int startIndex = 48;
    int NUMBER_OF_CHARS = len;
    char data[NUMBER_OF_CHARS];
    NSString *filterStr = @"58,59,60,61,62,63,64,91,92,93,94,95,96";
    NSRange findRange;
    for (int x = 0;x < NUMBER_OF_CHARS;x++)
    {
        int randomIndex = 0;
        do {
            randomIndex = arc4random_uniform(75);
            findRange = [filterStr rangeOfString:[NSString stringWithFormat:@"%d", randomIndex + startIndex]];
        } while (findRange.length > 0);
        
        data[x] = (char)(startIndex + randomIndex);
    }
    return [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
}


@end
