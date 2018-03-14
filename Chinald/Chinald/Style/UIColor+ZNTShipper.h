//
//  UIColor+ZNTShipper.h
//  ICOCShipper
//
//  Created by shichuang on 2017/8/31.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRGB:rgbValue]
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRGB:rgbValue alpha:alphaValue]

@interface UIColor (ZNTShipper)

+ (UIColor *)orangeColor;
+ (UIColor *)zntThemeTintColor;
+ (UIColor *)zntThemeTextColor;
+ (UIColor *)zntNavTitleColor;
+ (UIColor *)zntThemeBackgroundColor;
+ (UIColor *)zntVCBackgroundColor;
+ (UIColor *)zntNavBackgroundColor;
+ (UIColor *)zntPlaceholderColor;
+ (UIColor *)zntBtnColor1;

+ (UIColor *)zntTextColor1;
+ (UIColor *)zntTextColor2;
+ (UIColor *)zntTextColor3;
+ (UIColor *)zntTextColor4;


+ (UIColor *)zntBackgroundColor3;
+ (UIColor *)zntBackgroundColor4;
+ (UIColor *)zntBackgroundColor5;
+ (UIColor *)zntBackgroundColor6;    /**< F7F9FA v8下所有列表cell的背景色 */
+ (UIColor *)zntBackgroundColor7;
+ (UIColor *)zntDividingLineColor;
+ (UIColor *)zntSubtitleColor;

+ (UIColor *)colorWithRGB:(int)rgbValue;
+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;

@end
