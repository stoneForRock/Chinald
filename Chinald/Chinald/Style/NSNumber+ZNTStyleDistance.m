//
//  NSNumber+ZNTStyleDistance.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "NSNumber+ZNTStyleDistance.h"

@implementation NSNumber (ZNTStyleDistance)

+ (CGFloat)zntDistance1 {
    return 12.0f;
}

+ (CGFloat)zntDistance2 {
    return 8.0f;
}

+ (CGFloat)zntDistance3 {
    return 23.0f;
}

+ (CGFloat)zntLeftItemDistance {
    if (isiPhone6Plus) {
        return 0.0f;
    }
    return 4.0f;
}

+ (CGFloat)zntRightItemDistance {
    return -[self zntLeftItemDistance];
}


@end
