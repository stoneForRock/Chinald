//
//  UIView+ZNTAdd.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZNTAdd)

@property CGPoint znt_origin;
@property CGSize  znt_size;
@property CGFloat znt_height;
@property CGFloat znt_width;
@property CGFloat znt_top;
@property CGFloat znt_left;
@property CGFloat znt_bottom;
@property CGFloat znt_right;

@property CGFloat znt_x;
@property CGFloat znt_y;
@property CGFloat znt_max_X;
@property CGFloat znt_max_Y;
@property CGFloat znt_centerX;
@property CGFloat znt_centerY;
/**
 添加分割线
 */
- (UIView *)znt_addLineAtRect:(CGRect)rect;

/**
 圆角
 */
- (void)setRadius:(CGFloat)radius;

/**
 阴影
 */
- (void)setDefaultShadow;


/**
 获取cell的tableView
 */
- (UITableView *)getSuperTableView;

/**
 缺失页提示
 */
- (void)znt_showNoDataView:(NSString *)text;
- (void)znt_hideNoDataView;

/**
 网页加载中提示
 */
- (void)znt_showContentLoadingView;
- (void)znt_hideContentLoadingView;

@end
