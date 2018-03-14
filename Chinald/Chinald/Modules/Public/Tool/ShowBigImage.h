//
//  ShowBigImage.h
//  DGroupPatient
//
//  Created by 张东文 on 15/7/21.
//  Copyright (c) 2015年 Dachen Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class ShowBigImage;
@protocol ShowBigImageDelegate <NSObject>
@optional

- (void)reUploadImageAction:(ShowBigImage *)bigImage;

@end

typedef NS_ENUM(NSInteger,ShowBigImageStyle) {
    ShowBigImageNormalStyle = 0,//默认style 只是用来查看图片
    ShowBigImageUploadStyle,//上传模式，可以取消或者重新上传
};

@interface ShowBigImage : UIView<UIScrollViewDelegate>
{
    UIScrollView        *scrollView_;
    UILabel             *labelNumber_;
}

/**
 显示图片的风格
 */
@property (nonatomic, assign) ShowBigImageStyle showStyle;
@property (nonatomic, assign) id<ShowBigImageDelegate> bigImagedelegate;

- (void)showWithImage:(id)image;
- (void)showWithImageArr:(NSArray *)arrImage index:(NSInteger)intIndex;


@end
