//
//  NSObject+ZNTAdd.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ZNTAdd)
- (BOOL)znt_isNull;
- (NSString *)znt_safeString;
- (NSNumber *)znt_safeNumber;
- (NSArray *)znt_safeArray;

@end
