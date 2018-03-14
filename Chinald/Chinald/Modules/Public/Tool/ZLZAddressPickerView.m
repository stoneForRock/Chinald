//
//  ZLZAddressPickerView.m
//  ZLZYangMing
//
//  Created by dachen on 2017/7/28.
//  Copyright © 2017年 Joey. All rights reserved.
//

#import "ZLZAddressPickerView.h"

@interface ZLZAddressPickerView()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cover;

@end

@implementation ZLZAddressPickerView

- (void)setPickerViewTag:(NSInteger)pickerViewTag {
    _pickerViewTag = pickerViewTag;
    self.pickerView.tag = pickerViewTag;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = CGRectMake(0, ScreenFullHeight, ScreenFullWidth, self.znt_height);
    self.cover = [[UIButton alloc] init];
    self.cover.backgroundColor = [UIColor blackColor];
    self.cover.alpha = 0;
    self.cover.frame = CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight);
    [self.cover addTarget:self action:@selector(clickCover:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    [ZLZAddressPickerView hidePickerView:self];
}

- (IBAction)commitAction:(UIButton *)sender {
    if (self.pickerBlock) {
        self.pickerBlock(YES);
    }
    [ZLZAddressPickerView hidePickerView:self];
}

- (void)clickCover:(UIButton *)sender
{

    [ZLZAddressPickerView hidePickerView:self];
}

+ (instancetype)initWithTitle:(NSString *)title delegate:(id<UIPickerViewDelegate>)delegate pickerBlock:(void (^)(BOOL confirm))pickerBlock
{
    ZLZAddressPickerView *picker = [[[NSBundle mainBundle] loadNibNamed:@"ZLZAddressPickerView" owner:self options:nil] firstObject];
    picker.titleLabel.text = title;
    picker.pickerView.delegate = delegate;
    picker.pickerBlock = pickerBlock;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:picker.cover];
    [window addSubview:picker];
    
    return picker;
}

+ (void)showPickerView:(ZLZAddressPickerView *)picker {
    [picker.pickerView reloadAllComponents];
    [UIView animateWithDuration:0.25 animations:^{
        picker.cover.alpha = 0.4;
        picker.znt_y = ScreenFullHeight - picker.znt_height;
    }];
}

+ (void)hidePickerView:(ZLZAddressPickerView *)picker
{
    [UIView animateWithDuration:0.15 animations:^{
        picker.cover.alpha = 0;
        picker.znt_y = ScreenFullHeight;
    } completion:^(BOOL finished) {
    }];
}


+ (void)removePickerView:(ZLZAddressPickerView *)picker {
    [picker.cover removeFromSuperview];
    [picker removeFromSuperview];
}

@end
