//
//  KDInputView.h
//  kdweibo
//
//  Created by Darren on 15/7/10.
//  Copyright © 2015年 www.kingdee.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHSPhoneLibrary.h"
/*
 [imageViewLeft/label] [textFieldMain] [imageViewRight/label)]
 --------------------------------------------------------
 */

typedef NS_ENUM(NSInteger,KDInputViewElement)
{
    KDInputViewElementNone              = 0,        // 纯文本框
    KDInputViewElementImageViewLeft     = 1 << 0,   // 左为图片
    KDInputViewElementLabelLeft         = 1 << 1,   // 左为文本
    KDInputViewElementButtonRight       = 1 << 2,   // 右为按钮
    KDInputViewElementCountryCodeLeft   = 1 << 3,   // 左为（国家+区号+分隔线）
    KDInputViewElementLabelRight        = 1 << 4,   // 右为文本
    KDInputViewElementLongLabelLeft     = 1 << 5,   // 右为文本
    KDInputViewElementAuthPassword      = 1 << 6,   // 登录输入密码
    KDInputViewElementZLZInputView      = 1 << 7,   // 致良知
};

@interface KDInputView : UIView

//  指定初始化方法。element:样式，复选; shouldFormatPhoneNumber:是否格式化电话, 默认NO

// 白色模式
- (instancetype)initWithElement:(KDInputViewElement)element shouldFormatPhoneNumber:(BOOL)bShouldFormatPhoneNumber;

// 蓝色模式
- (instancetype)initAuthInputWithElement:(KDInputViewElement)element shouldFormatPhoneNumber:(BOOL)bShouldFormatPhoneNumber;

//add for zlz business 致良知登录专用
- (instancetype)initZLZBisinessInputWithElement:(KDInputViewElement)element shouldFormatPhoneNumber:(BOOL)bShouldFormatPhoneNumber;


- (void)updateWithElement:(KDInputViewElement)element;

// 控件指针
@property (nonatomic, strong) UITextField *textFieldMain;                 // 主文本框
@property (nonatomic, copy) void (^textDidChangeBlock)(UITextField *textField); // SHS专用，bShouldFormatPhoneNumber = YES的情况下需要textDidChange的时候。target方式SHS控件不支持， 不要通过原生的textFieldMain.textDidChangeBlock来访问，否则会覆盖本类中得实现。

@property (nonatomic, copy) void (^countryCodeBlock)();

@property (nonatomic, strong) UIImageView *imageViewLeft;                       // 图标
@property (nonatomic, strong) UIButton *buttonRight;                            // 密码明文眼睛
@property (nonatomic, copy) void (^blockButtonRightPressed)(UIButton *button);  // 右侧按钮点击
@property (nonatomic, strong) UILabel *labelRight;                              // 倒计时
@property (nonatomic, strong) UILabel *labelLeft;                               // +86
@property (nonatomic, strong) UIView *viewLine;                                 // 未激活灰色，激活蓝色
@property (nonatomic, assign) float fButtonRightWidth;   // 右侧按钮的宽度

@property (nonatomic, strong) UILabel *phoneNumLeft;        // 国家区号
@property (nonatomic, strong, readonly) UIView *midDivLine;
@property (nonatomic, strong, readonly) UIImageView *arrow; // 国际手机号 向下箭头

- (void)changeToKDV7Style;

- (void)changeToZLZStyle;

- (void)changeToWarnStyle:(BOOL)warnBool;

@end
