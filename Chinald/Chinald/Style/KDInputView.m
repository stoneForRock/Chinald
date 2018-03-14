//
//  KDInputView.m
//  kdweibo
//
//  Created by Darren on 15/7/10.
//  Copyright © 2015年 www.kingdee.com. All rights reserved.
//

#import "KDInputView.h"
#import <Masonry/Masonry.h>
#import "UIView+ZNTAdd.h"

@interface KDInputView ()
@property (nonatomic, assign) CGFloat v7StyleSpace;
@property (nonatomic, assign) KDInputViewElement element;
@property (nonatomic, assign) BOOL bShouldFormatPhoneNumber;
@property (nonatomic, strong) UIView *midDivLine;
@property (nonatomic, assign) BOOL isAuthMode;
@property (nonatomic, strong) UIImageView *arrow;

@property (nonatomic, assign) BOOL isWarnStyle;
@end

@implementation KDInputView


- (instancetype)initWithElement:(KDInputViewElement)element shouldFormatPhoneNumber:(BOOL)bShouldFormatPhoneNumber
{
    if (self = [super init]) {
        _v7StyleSpace = 0.0;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.element = element;
        self.isAuthMode = NO;
        self.bShouldFormatPhoneNumber = bShouldFormatPhoneNumber;
        [self updateWithElement:element];
    }
    return self;
}

- (instancetype)initAuthInputWithElement:(KDInputViewElement)element shouldFormatPhoneNumber:(BOOL)bShouldFormatPhoneNumber {

    if (self = [super init]) {
        _v7StyleSpace = 0.0;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.element = element;
        self.isAuthMode = YES;
        self.bShouldFormatPhoneNumber = bShouldFormatPhoneNumber;
        [self updateWithElement:element];
    }
    return self;
}

- (instancetype)initZLZBisinessInputWithElement:(KDInputViewElement)element shouldFormatPhoneNumber:(BOOL)bShouldFormatPhoneNumber {
    
    if (self = [super init]) {
        _v7StyleSpace = 0.0;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.element = element;
        self.isAuthMode = YES;
        self.bShouldFormatPhoneNumber = bShouldFormatPhoneNumber;
        [self updateWithElement:element];
    }
    return self;
}

- (void)updateWithElement:(KDInputViewElement)element
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
//    [self.viewLine removeFromSuperview];
//    [self.imageViewLeft removeFromSuperview];
//    [self.labelLeft removeFromSuperview];
//    [self.buttonRight removeFromSuperview];
//    [self.labelRight removeFromSuperview];
//    [self.textFieldMain removeFromSuperview];
//    [self.midDivLine removeFromSuperview];

    self.labelLeft.userInteractionEnabled = NO;
    
    // 画线
    [self addSubview:self.viewLine];

    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.mas_left).with.offset(0);
         make.right.equalTo(self.mas_right).with.offset(-0);
         make.bottom.equalTo(self.mas_bottom).with.offset(-0);
         make.height.mas_equalTo(0.5);
     }];
    
    // 左侧图片/文本二选一
    if ([self containElement:KDInputViewElementImageViewLeft]) {
        [self addSubview:self.imageViewLeft];

        [self.imageViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(_v7StyleSpace?_v7StyleSpace:6);
             make.width.mas_equalTo(15);
             make.height.mas_equalTo(20);
             make.centerY.equalTo(self.mas_centerY);
         }];
    }
    else if ([self containElement:KDInputViewElementAuthPassword]) {

        [self addSubview:self.labelLeft];

        [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(_v7StyleSpace);
            make.width.mas_equalTo(35);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }

    else if ([self containElement:KDInputViewElementLabelLeft]) {
        [self addSubview:self.labelLeft];

        [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.mas_left).with.offset(_v7StyleSpace);
             make.width.mas_equalTo(60);
             make.centerY.equalTo(self.mas_centerY);
         }];
    }
    else if ([self containElement:KDInputViewElementLongLabelLeft]) {
        [self addSubview:self.labelLeft];
        
        [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.mas_left).with.offset(_v7StyleSpace);
             make.width.mas_equalTo(58);
             make.centerY.equalTo(self.mas_centerY);
         }];
    }
    else if ([self containElement:KDInputViewElementCountryCodeLeft]) { // 国家区号

        self.labelLeft.userInteractionEnabled = YES;


//        [self addSubview:self.arrow];
        [self addSubview:self.labelLeft];
        [self addSubview:self.midDivLine];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toCountryCodeVC:)];
        [self.labelLeft addGestureRecognizer:tap];

        [self.midDivLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(48);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(20);
            make.centerY.equalTo(self.mas_centerY);
        }];

//        CGSize arrowSize = self.arrow.image.size;
//        [self.arrow makeConstraints:^(MASConstraintMaker *make) {
//
//            make.width.mas_equalTo(arrowSize.width);
//            make.height.mas_equalTo(arrowSize.height);
//            make.right.equalTo(self.midDivLine.left).with.offset(-[NSNumber kdDistance1]);
//            make.centerY.equalTo(self.centerY);
//        }];

        [self.labelLeft mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.mas_left).with.offset([NSNumber zntDistance2]);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(30);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }


    // 右侧按钮/文本二选一
    if ([self containElement:KDInputViewElementButtonRight]) {
        [self addSubview:self.buttonRight];

        [self.buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
             if (self.fButtonRightWidth>0) {
                 make.width.mas_equalTo(self.fButtonRightWidth);
             }
             else {
                 make.width.mas_equalTo(70);
             }
             make.right.equalTo(self.mas_right).with.offset(- 20);
             make.height.mas_equalTo(30);
             make.centerY.equalTo(self.mas_centerY);
         }];
    }
    else if ([self containElement:KDInputViewElementLabelRight]) {
        [self addSubview:self.labelRight];
        
        [self.labelRight mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(self.mas_right).with.offset(-_v7StyleSpace);
             make.width.mas_equalTo(20);
             make.centerY.equalTo(self.mas_centerY);
         }];
    }
    
    // 确定了左和右，开始算中间文本框
    [self addSubview:self.textFieldMain];
    
    [self.textFieldMain mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.mas_centerY);
         if ([self containElement:KDInputViewElementImageViewLeft]) {
             make.left.equalTo(self.imageViewLeft.mas_right).with.offset(_v7StyleSpace > 0? _v7StyleSpace : 16);
         }
         else if ([self containElement:KDInputViewElementLabelLeft]) {
             make.left.equalTo(self.labelLeft.mas_right).with.offset(0);
         }
         else if ([self containElement:KDInputViewElementLongLabelLeft]) {
             make.left.equalTo(self.labelLeft.mas_right).with.offset(0);
         }
         else if ([self containElement:KDInputViewElementCountryCodeLeft]) {
             make.left.equalTo(self.midDivLine.mas_right).with.offset(8);
         }
         else if ([self containElement:KDInputViewElementAuthPassword]) {
             make.left.equalTo(self.mas_left).with.offset(85.5+8);
             make.right.equalTo(self.buttonRight.mas_left).with.offset(0);
         }else if ([self containElement:KDInputViewElementZLZInputView]) {
             make.left.equalTo(self.mas_left).with.offset(20);
         }
         else if ([self containElement:KDInputViewElementButtonRight]) {
             make.left.equalTo(self.mas_left).with.offset(20);
         }
         else {
             make.left.equalTo(self.mas_left).with.offset(_v7StyleSpace);
         }
         
         if ([self containElement:KDInputViewElementButtonRight]) {
             make.right.equalTo(self.buttonRight.mas_left).with.offset(0);
         }
         else if ([self containElement:KDInputViewElementLabelRight]) {
             make.right.equalTo(self.labelRight.mas_left).with.offset(_v7StyleSpace > 0? _v7StyleSpace : 9);
         }
         else if ([self containElement:KDInputViewElementZLZInputView]) {
             make.right.equalTo(self.mas_right).with.offset(-20);
         }
         else {
             make.right.equalTo(self.mas_right).with.offset(-_v7StyleSpace);
         }
     }];
}

//- (void)setElement:(KDInputViewElement)element
//{
//    [self updateWithElement:element];
//}


- (void)drawRect:(CGRect)rect
{
    
}

- (BOOL)containElement:(KDInputViewElement)el
{
    return (self.element & el) == el;
}

#pragma mark - UITextField Notification

- (void)textFieldMainEditingDidBegin
{
    self.viewLine.backgroundColor = self.isAuthMode?[UIColor colorWithHexRGB:@"2e63b6" alpha:.2f]:ThemeColor;
    
    if (self.isAuthMode) {
//        self.backgroundColor = [UIColor clearColor];
    }
    
    if (self.viewLine.isHidden) {
        
        self.layer.borderColor = self.isAuthMode?[UIColor colorWithHexRGB:@"ccf7ff" alpha:0.5f].CGColor:ThemeTextColor.CGColor;
        self.layer.borderWidth = 1.f;
    }
    
    if (self.isWarnStyle) {
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.f;
    }
}

- (void)textFieldMainEditingDidEnd
{
    self.viewLine.backgroundColor = LineColor;
    
    if (self.isAuthMode) {
//        self.backgroundColor = [UIColor clearColor];
    }
    
    if (self.viewLine.isHidden) {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0.0;
    }
}

- (void)textChanged
{
    if (self.textFieldMain.text.length > 0) {
        self.textFieldMain.textColor = self.isAuthMode?ThemeTextColor: ThemeTextColor;
    }
    else {
        self.textFieldMain.textColor = self.isAuthMode?ThemeTextColor: ThemeTextColor;
    }
}

#pragma mark - UIButton Action

- (void)buttonRightPressed:(UIButton *)button
{
    if (self.blockButtonRightPressed) {
        self.blockButtonRightPressed(button);
    }
}

#pragma mark - KDStyle Setting 

- (void)changeToZLZStyle {
    _v7StyleSpace = 20.f;
    [self updateWithElement:self.element];
    
    self.clipsToBounds = YES;
    self.viewLine.hidden = NO;
    self.backgroundColor = self.isAuthMode?[UIColor clearColor]:ThemeBacgroundColor;
}

- (void)changeToKDV7Style
{
    _v7StyleSpace = 20.f;
    [self updateWithElement:self.element];
    
    self.clipsToBounds = YES;
    self.viewLine.hidden = YES;
    self.backgroundColor = self.isAuthMode?[UIColor colorWithHexRGB:@"2e63b6" alpha:.2f]:ThemeBacgroundColor;
}

- (void)changeToWarnStyle:(BOOL)warnBool
{
    _v7StyleSpace = 20.f;
    
    self.clipsToBounds = YES;
    self.viewLine.hidden = YES;
    self.backgroundColor = warnBool ? [UIColor colorWithRGB:0xFFF1F1]:ThemeBacgroundColor;
    self.layer.borderColor = warnBool ? Color4.CGColor : ThemeTextColor.CGColor;
    self.isWarnStyle = warnBool ? YES : NO;
    self.layer.borderWidth = 1.f;
}

#pragma mark - Getter/Setter

- (UILabel *)labelLeft
{
    if (!_labelLeft) {
        _labelLeft = [UILabel new];
        _labelLeft.numberOfLines = 2;
        _labelLeft.textAlignment = NSTextAlignmentLeft;
        _labelLeft.font = Font13;
        _labelLeft.backgroundColor = ThemeBacgroundColor;
        _labelLeft.textColor = ThemeTextColor;
//        _labelLeft.layer.masksToBounds = YES;
//        _labelLeft.layer.cornerRadius = 15;
    }
    return _labelLeft;
}

- (UILabel *)labelRight
{
    if (!_labelRight) {
        _labelRight = [UILabel new];
    }
    return _labelRight;
}

- (UITextField *)textFieldMain
{
    if (!_textFieldMain) {
        if (self.bShouldFormatPhoneNumber) {
            _textFieldMain = [SHSPhoneTextField new];
            SHSPhoneTextField *tf = (SHSPhoneTextField *)_textFieldMain;
            [tf.formatter setDefaultOutputPattern:@"###-####-####"];
            tf.textDidChangeBlock = ^(UITextField *tf)
            {
                [self textChanged];
                if (self.textDidChangeBlock) {
                    self.textDidChangeBlock(tf);
                }
            };
        }
        else {
            _textFieldMain = [UITextField new];
            [_textFieldMain addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
        }
        [_textFieldMain addTarget:self action:@selector(textFieldMainEditingDidBegin) forControlEvents:UIControlEventEditingDidBegin];
        [_textFieldMain addTarget:self action:@selector(textFieldMainEditingDidEnd) forControlEvents:UIControlEventEditingDidEnd];
        
        _textFieldMain.font = Font14;
        _textFieldMain.textColor = ThemeTextColor;
        _textFieldMain.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textFieldMain;
}

- (UIImageView *)imageViewLeft
{
    if (!_imageViewLeft) {
        _imageViewLeft = [UIImageView new];
    }
    return _imageViewLeft;
}

- (UIButton *)buttonRight
{
    if (!_buttonRight) {
        _buttonRight = [UIButton new];
        [_buttonRight addTarget:self action:@selector(buttonRightPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonRight.titleLabel setFont:Font14];
        _buttonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_buttonRight setTitleColor:ThemeTextColor forState:UIControlStateNormal];
        
    }
    return _buttonRight;
}

- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [UIView new];
        _viewLine.backgroundColor = LineColor;
    }
    return _viewLine;
}

- (UIView *)midDivLine {
    if (!_midDivLine) {
        _midDivLine = [UIView new];
//        _midDivLine.backgroundColor = [UIColor kdDividingLineColor];
        _midDivLine.backgroundColor = [UIColor clearColor];
    }
    return _midDivLine;
}

- (UIImageView *)arrow {

    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        _arrow.image = [UIImage imageNamed:@"login_C_countryCode_arrow_down"];
    }
    return _arrow;
}


- (void)setFButtonRightWidth:(float)fButtonRightWidth
{
    _fButtonRightWidth = fButtonRightWidth;
    
    [self.buttonRight mas_updateConstraints:^(MASConstraintMaker *make) {
         if (self.fButtonRightWidth > 0) {
             make.width.mas_equalTo(self.fButtonRightWidth);
         }
         else {
             make.width.mas_equalTo(70);
         }
     }];
}

#pragma mark - private Method
- (void)toCountryCodeVC:(UITapGestureRecognizer *)sender {
    if (self.countryCodeBlock) {
        self.countryCodeBlock();
    }
}

@end
