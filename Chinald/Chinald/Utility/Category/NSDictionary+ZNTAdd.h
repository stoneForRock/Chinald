//
//  NSDictionary+ZNTAdd.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZNTAdd)

- (NSString *)toJSONString;

- (NSString *)toJSONStringWithoutPrinted;

// 验证去除空字符串
- (NSMutableDictionary *)HandleString;

@end
