//
//  UIImage+ZNTAdd.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZNTAdd)

+ (UIImage *)znt_imageWithColor:(UIColor *)color;

+ (UIImage *)znt_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)znt_imageWithColor:(UIColor *)color coverColor:(UIColor *)color;

+ (UIImage *)zntDefaultHeaderImage;

@end
