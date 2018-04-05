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
/**
 字体灰色333333
 
 @return UIColor
 */
+ (UIColor *)zntTextColor5;

+ (UIColor *)zntTextColor6;/**< 666666 字体淡灰色 */
+ (UIColor *)zntTextColor7;/**< 999999 字体淡灰色 */
+ (UIColor *)zntBackgroundColor3;
+ (UIColor *)zntBackgroundColor4;
+ (UIColor *)zntBackgroundColor5;
+ (UIColor *)zntBackgroundColor6;    /**< F7F9FA v8下所有列表cell的背景色 */
+ (UIColor *)zntBackgroundColor7;

/**
 主背景色
 @return 背景色
 */
+ (UIColor *)clVCBackgroundColor;

+ (UIColor *)zntDividingLineColor;
+ (UIColor *)clDividingLineColor;
+ (UIColor *)zntSubtitleColor;

+ (UIColor *)colorWithRGB:(int)rgbValue;
+ (UIColor *)colorWithRGB:(int)rgbValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString;
+ (UIColor *)colorWithHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;

@end
