//
//  NSObject+ZNTAdd.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "NSObject+ZNTAdd.h"

@implementation NSObject (ZNTAdd)
- (BOOL)znt_isNull {
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    } else if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)znt_safeString {
    if (!self || [self isEqual:[NSNull null]] || ![self isKindOfClass:[NSString class]]) {
        return @"";
    }
    return (NSString *)self;
}

- (NSNumber *)znt_safeNumber {
    if (!self || [self isEqual:[NSNull null]] || ![self isKindOfClass:[NSNumber class]]) {
        return @0;
    }
    return (NSNumber *)self;
}

- (NSArray *)znt_safeArray {
    if (!self || [self isEqual:[NSNull null]] || ![self isKindOfClass:[NSArray class]]) {
        return @[];
    }
    return (NSArray *)self;
}
@end
