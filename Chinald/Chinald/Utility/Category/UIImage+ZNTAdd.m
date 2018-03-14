//
//  UIImage+ZNTAdd.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UIImage+ZNTAdd.h"

@implementation UIImage (ZNTAdd)

+ (UIImage *)znt_imageWithColor:(UIColor *)color {
    return [self znt_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)znt_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)znt_imageWithColor:(UIColor *)color coverColor:(UIColor *)coverColor
{
    UIImage *image1 = [UIImage znt_imageWithColor:color];
    UIImage *image2 = [UIImage znt_imageWithColor:coverColor];
    
    UIGraphicsBeginImageContext(image1.size);
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

+ (UIImage *)zntDefaultHeaderImage {
    return [UIImage imageNamed:@"default_header"];
}

@end
