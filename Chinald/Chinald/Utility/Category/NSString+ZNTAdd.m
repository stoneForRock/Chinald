//
//  NSString+ZNTAdd.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "NSString+ZNTAdd.h"

@implementation NSString (ZNTAdd)

//获取唯一uuid
+ (NSString *)uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    NSString	*uuidString = [[uuid lowercaseString] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    return uuidString;
}

@end

@implementation NSString (ZNTRegular)

- (BOOL)isNumText {
    
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isCountryPhone {
    NSRegularExpression *regx= [NSRegularExpression regularExpressionWithPattern:@"[\\+]" options:0 error:nil];
    NSRange range = [regx rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
    if (range.location != NSNotFound) {
        return YES;
        
    }
    return NO;
}

@end

@implementation NSString (ZNTTimeFormatter)

- (NSString *)changeToDateStringWithformatter:(NSString *)fomatter {
    static NSDateFormatter *formater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formater = [NSDateFormatter new];
    });
    [formater setDateFormat:fomatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formater stringFromDate:date];
}

- (NSDate *)changeToDate {
    return [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
}

- (NSString *)changeSecondToDateStringWithformatter:(NSString *)fomatter {
    static NSDateFormatter *formater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formater = [NSDateFormatter new];
    });
    [formater setDateFormat:fomatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    return [formater stringFromDate:date];
}

//将时间戳转换为00点的时间戳
- (NSString *)changeToDateTimeInterval {
    static NSDateFormatter *formater = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formater = [NSDateFormatter new];
    });
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    NSString *dateString = [formater stringFromDate:date];
    NSDate *dayDate = [formater dateFromString:dateString];
    
    return [NSString stringWithFormat:@"%.f",[dayDate timeIntervalSince1970] * 1000];
}

- (NSInteger)getMaxStringLength {
    NSInteger length = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - self.length) / 2;
    length = (length +1) / 2;
    return length;
}

- (NSInteger)getMinStringLength {
    NSInteger length = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    length -= (length - self.length) / 2;
    length = (length) / 2;
    return length;
}


@end

@implementation NSString (ZNTSafeString)

- (NSString *)safeString {
    if (self == nil || [self isEqual:[NSNull null]]) {
        return @"";
    }
    return self;
}

- (NSString *)znt_trimWhitespaceAndNewline {
    NSString *trimString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimString;
}

@end

@implementation  NSString (ZNTEncode)

- (NSString *)urlStringEncode {
    NSString *escapedString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    return escapedString;
}

@end


@implementation NSString (ZNTStringSize)

- (CGSize)sizeWithFont:(UIFont *)font height:(CGFloat)height {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size;
}

@end
