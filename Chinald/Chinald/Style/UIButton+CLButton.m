//
//  UIButton+CLButton.m
//  Chinald
//
//  Created by WPFBob on 2018/3/27.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "UIButton+CLButton.h"

@implementation UIButton (CLButton)
+(void)imageUpTextDownWithButton:(UIButton *)button TextFont:(float)textFont{
    CGRect contentSize = [button.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, button.titleLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont ]} context:nil];
    CGSize textSize = contentSize.size;
    
    float textSizeWidth;
    if ([[UIScreen mainScreen] bounds].size.width == 320) {
        textSizeWidth = textSize.width > 35 ? 35  : textSize.width;
    }else{
        textSizeWidth = textSize.width;
    }
    button.titleEdgeInsets =UIEdgeInsetsMake(0.5*button.imageView.image.size.height + 10, - 0.5*button.imageView.image.size.width - 10, -0.5*button.imageView.image.size.height, 0.5*button.imageView.image.size.width - 10);
    button.imageEdgeInsets =UIEdgeInsetsMake(-0.5*textSize.height,  0.5 * textSizeWidth , 0.5*textSize.height ,  -0.5 * textSizeWidth);
}
@end
