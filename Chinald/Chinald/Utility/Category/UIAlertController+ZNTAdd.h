//
//  UIAlertController+ZNTAdd.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (ZNTAdd)

@property (nonatomic,strong) UIColor *tintColor; /**< 统一按钮样式 不写系统默认的蓝色 */
@property (nonatomic,strong) UIColor *titleColor; /**< 标题的颜色 */
@property (nonatomic,strong) UIColor *messageColor; /**< 信息的颜色 */

@end

@interface UIAlertAction (Color)

@property (nonatomic,strong) UIColor *textColor; /**< 按钮title字体颜色 */

@end
