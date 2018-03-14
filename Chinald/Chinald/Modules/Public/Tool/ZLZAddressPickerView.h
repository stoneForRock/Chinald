//
//  ZLZAddressPickerView.h
//  ZLZYangMing
//
//  Created by dachen on 2017/7/28.
//  Copyright © 2017年 Joey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLZAddressPickerView : UIView

@property (nonatomic, copy) void (^pickerBlock)(BOOL confirm);
@property (nonatomic, assign) NSInteger pickerViewTag;

+ (instancetype)initWithTitle:(NSString *)title delegate:(id<UIPickerViewDelegate>)delegate pickerBlock:(void (^)(BOOL confirm))pickerBlock;

+ (void)showPickerView:(ZLZAddressPickerView *)picker;

+ (void)hidePickerView:(ZLZAddressPickerView *)picker;

+ (void)removePickerView:(ZLZAddressPickerView *)picker;

@end
