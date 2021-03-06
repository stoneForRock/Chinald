//
//  UIColor+ZNTShipper.m
//  ICOCShipper
//
//  Created by shichuang on 2017/8/31.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UIColor+ZNTShipper.h"

@implementation UIColor (ZNTShipper)

+ (UIColor *)zntThemeTintColor {
    return [self colorWithRGB:0xA366FF];
}

+ (UIColor *)orangeColor {
    return [self colorWithRGB:0xFFA200];
}

+ (UIColor *)zntThemeTextColor {
    return [self colorWithRGB:0xB4B4B4];
}

+ (UIColor *)zntNavTitleColor {
    return [self colorWithRGB:0x000000];
}

+ (UIColor *)zntThemeBackgroundColor {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)zntVCBackgroundColor {
    return [self colorWithRGB:0xF2F2F2];
}

+ (UIColor *)clVCBackgroundColor {
    return [self colorWithRGB:0xF6F6F6];
}

+ (UIColor *)zntNavBackgroundColor {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)zntPlaceholderColor {
    return [self colorWithRGB:0xb2b2b2];
}

+ (UIColor *)zntBtnColor1 {
    return [self colorWithRGB:0x0096ff];
}

+ (UIColor *)zntTextColor1 {
    return [self colorWithRGB:0x030303];
}

+ (UIColor *)zntTextColor2 {
    return [self colorWithRGB:0xd8d8d8];
}

+ (UIColor *)zntTextColor3 {
    return [self colorWithRGB:0x030303];
}

+ (UIColor *)zntTextColor4 {
    return [self colorWithRGB:0x030303];
}

/**
 字体灰色333333

 @return UIColor
 */
+ (UIColor *)zntTextColor5 {
    return [self colorWithRGB:0x333333];
}
+ (UIColor *)zntTextColor6 {
    return [self colorWithRGB:0x666666];
}
+ (UIColor *)zntTextColor7 {
    return [self colorWithRGB:0x999999];
}


+ (UIColor *)zntBackgroundColor3 {
    return [self colorWithRGB:0x030303];
}

+ (UIColor *)zntBackgroundColor4 {
    return [self colorWithRGB:0x030303];
}

+ (UIColor *)zntBackgroundColor5 {
    return [self colorWithRGB:0x030303];
}

/**< F7F9FA v8下所有列表cell的背景色 */
+ (UIColor *)zntBackgroundColor6 {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)zntBackgroundColor7 {
    return [self colorWithRGB:0xFFFFFF];
}

+ (UIColor *)zntDividingLineColor {
    return [self colorWithRGB:0xcecece];
}
+ (UIColor *)clDividingLineColor{
    return [self colorWithRGB:0xd9d9d9];
}
+ (UIColor *)zntSubtitleColor {
    return [self colorWithRGB:0xFFFFFF];
}



+ (UIColor *)colorWithRGB:(int)rgbValue {
    return [UIColor colorWithRGB:rgbValue
                           alpha:1];
}

+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float) (((rgbValue) & 0xFF0000) >> 16)) / 255.0
                           green:((float) (((rgbValue) & 0x00FF00) >> 8)) / 255.0
                            blue:((float) ((rgbValue) & 0x0000FF)) / 255.0
                           alpha:alpha];
}

+ (UIColor *)colorWithHexRGB:(NSString *)inColorString {
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:1.0];
    
    return result;
}

+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha {
    UIColor *result = nil;
    
    unsigned int colorCode = 0;
    
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
        
    {
        
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        
        (void) [scanner scanHexInt:&colorCode]; // ignore error
        
    }
    
    redByte = (unsigned char) (colorCode >> 16);
    
    greenByte = (unsigned char) (colorCode >> 8);
    
    blueByte = (unsigned char) (colorCode); // masks off high bits
    
    result = [UIColor
              
              colorWithRed: (float)redByte / 0xff
              
              green: (float)greenByte/ 0xff
              
              blue: (float)blueByte / 0xff
              
              alpha:alpha];
    
    return result;
}

@end
