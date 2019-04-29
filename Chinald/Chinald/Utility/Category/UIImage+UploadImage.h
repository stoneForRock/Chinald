//
//  UIImage+UploadImage.h
//  taxinvoicebox
//
//  Created by WPFBob on 2017/8/18.
//  Copyright © 2017年 vanvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UploadImage)

/**
 通过二分法 压缩图片小于指定大小（不一定100%达到效果）

 @param image 需要压缩的图片
 @param maxLength 图片文件最大值
 @return 压缩后的文件
 */
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

/**
 图片格式

 @param image 需要获取格式的图片
 @return 返回图片格式
 */
+ (NSString *)imageFormat:(UIImage *)image;
@end
