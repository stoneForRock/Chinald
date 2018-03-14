//
//  NSDictionary+ZNTAdd.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "NSDictionary+ZNTAdd.h"

@implementation NSDictionary (ZNTAdd)

- (NSString *)toJSONString
{
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return str;
}

- (NSString *)toJSONStringWithoutPrinted
{
    NSError *error;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return str;
}

// 验证去除空字符串
- (NSMutableDictionary *)HandleString
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:self];
    
    NSArray *arrKey = [dic allKeys];
    for (int i = 0; i < arrKey.count; i++)
    {
        id idWhat = dic[arrKey[i]];
        
        if ([idWhat isKindOfClass:[NSDictionary class]])
        {
            dic[arrKey[i]] = [idWhat HandleString];
        }
        else if ([idWhat isKindOfClass:[NSArray class]])
        {
            dic[arrKey[i]] = [idWhat HandleString];
        }
        else if ([idWhat isKindOfClass:[NSString class]])
        {
            if ([idWhat isEqualToString:@"null"] || [idWhat isEqualToString:@"(null)"])
            {
                dic[arrKey[i]] = @"";
            }
        }
        else if ([idWhat isKindOfClass:[NSNumber class]])
        {
            dic[arrKey[i]] = [idWhat stringValue];
        }
        else
        {
            dic[arrKey[i]] = @"";
        }
    }
    
    return dic;
}

@end
