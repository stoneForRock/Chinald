//
//  ZNTThemeButton.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/6.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNTThemeButton : UIButton

- (void)updateStyle;
- (void)updateCancelStyle;

- (void)enableTouch;
- (void)blueEnableTouch;
- (void)orangeEnableTouch;
- (void)grayDisableTouch;
- (void)disableTouch;

- (void)unSeleted;

@end
