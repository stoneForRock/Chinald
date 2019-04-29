//
//  UIImage+UploadImage.m
//  taxinvoicebox
//
//  Created by WPFBob on 2017/8/18.
//  Copyright © 2017年 vanvy. All rights reserved.
//

#import "UIImage+UploadImage.h"

@implementation UIImage (UploadImage)
+ (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    NSData *data1 = UIImageJPEGRepresentation(image, 1);
    
    NSLog(@"data.length=====%lu",(unsigned long)data1.length);
    
    NSLog(@"image的图片格式是===%@",[self imageFormat:image]);
    float imageMaxWidth = image.size.width > 1280 ? 1280 : image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(imageMaxWidth, image.size.height / (float)image.size.width * imageMaxWidth ));
    [image drawInRect:CGRectMake(0,0,imageMaxWidth, image.size.height / (float)image.size.width * imageMaxWidth )];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGFloat compression = 0.85;
    NSData *data = UIImageJPEGRepresentation(newImage, compression);
//    if (data.length < maxLength) return newImage;
//    CGFloat max = 1;
//    CGFloat min = 0;
//    for (int i = 0; i < 6; ++i) {
//        compression = (max + min) / 2;
//        data = UIImageJPEGRepresentation(newImage, compression);
//        if (data.length < maxLength * 0.9) {
//            min = compression;
//        } else if (data.length > maxLength) {
//            max = compression;
//        } else {
//            break;
//        }
//    }
    
    UIImage *resultImage = [UIImage imageWithData:data];

    return resultImage;
}
/**
 图片格式
 
 @param image 需要获取格式的图片
 @return 返回图片格式
 */
+ (NSString *)imageFormat:(UIImage *)image{
    
    uint8_t c;
    NSData *data = UIImageJPEGRepresentation(image , 1);
    [data getBytes:&c length:1];
    
    
    
    switch (c) {
            
        case 0xFF:
            
            return @"jpg";
            
        case 0x89:
            
            return @"png";
            
        case 0x47:
            
            return @"gif";
            
        case 0x49:
            
        case 0x4D:
            
            return @"tiff";
            
    }
    
    return @"png";
}
@end
