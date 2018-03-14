//
//  UIImage+DZCategory.h
//  DZFoundation
//
//  Created by Darren on 15/5/28.
//  Copyright (c) 2015年 Darren Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DZCategory)

// 压缩图片大小：改变其分辨率
- (UIImage *)resizedImageWithWidth:(CGFloat)width
                            height:(CGFloat)height
                            opaque:(BOOL)bOpaque
                             scale:(CGFloat)fScale;
- (UIImage *)resizedImageWithSize:(CGSize)size;
- (UIImage *)stretchedImageWithLeftCapRatio:(float)fLeft topCapRatio:(float)rTop;

- (UIImage *)kd_cropEqualScaleImageToSize:(CGSize)size;
@end
