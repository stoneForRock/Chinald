//
//  NSString+ZNTAdd.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZNTAdd)

//获取唯一uuid
+ (NSString *)uuidString;

@end

@interface NSString (ZNTRegular)

- (BOOL)isNumText;
- (BOOL)isCountryPhone;

@end

@interface NSString (ZNTTimeFormatter)

- (NSString *)changeToDateStringWithformatter:(NSString *)fomatter;
- (NSDate *)changeToDate;
- (NSString *)changeSecondToDateStringWithformatter:(NSString *)fomatter;
//将时间戳转换为00点的时间戳
- (NSString *)changeToDateTimeInterval;

//获取最大 按2个字母为一个汉子长度，来获取字符串的长度 比如3个字母为2
- (NSInteger)getMaxStringLength;

//获取最小 按2个字母为一个汉子长度，来获取字符串的长度 比如3个字母为1
- (NSInteger)getMinStringLength;

@end

@interface NSString (ZNTSafeString)

- (NSString *)safeString;

- (NSString *)znt_trimWhitespaceAndNewline;

@end

@interface NSString (ZNTEncode)

- (NSString *)urlStringEncode;

@end

@interface NSString (ZNTStringSize)

- (CGSize)sizeWithFont:(UIFont *)font height:(CGFloat)height;

@end



