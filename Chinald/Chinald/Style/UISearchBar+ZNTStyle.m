//
//  UISearchBar+ZNTStyle.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UISearchBar+ZNTStyle.h"

@implementation UISearchBar (ZNTStyle)

- (void)setCustomPlaceholder:(NSString *)placeholder {
    if (!placeholder || placeholder.length == 0) {
        placeholder = @"搜索";
    }
    [[UITextField appearanceWhenContainedIn:[self class], nil] setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName : Font11, NSForegroundColorAttributeName : ThemeColor}]];
}


@end
