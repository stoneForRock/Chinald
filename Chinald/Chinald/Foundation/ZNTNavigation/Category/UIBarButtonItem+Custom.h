//
//  UIBarButtonItem+Custom.h
//  kdweibo
//
//  Created by sevli on 16/9/9.
//  Copyright © 2016年 www.kingdee.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZNTNavigationItemStyle_Normal = 0,    // system
    ZNTNavigationItemStyle_Blue,
    ZNTNavigationItemStyle_White,
} ZNTNavigationItemStyle;



#define KDBARBUTTON_OFFSET_DEFAULT [UIBarButtonItem znt_leftSecondItemOffsetX]

@interface UIBarButtonItem (Custom)

/**
 *  返回按钮
 *
 *  @param target
 *  @param action
 *
 *  @return
 */
+ (UIBarButtonItem * _Nullable)znt_makeDefaultBackItemTarget:(nullable id)target
                                                     action:(nullable SEL)action;


/**
 *  自定义
 *
 *  @param customView
 *
 *  @return
 */
+ (UIBarButtonItem * _Nullable)znt_makeLeftItemWithCustomView:(nullable UIView *)customView;
+ (UIBarButtonItem * _Nullable)znt_makeRightItemWithCustomView:(nullable UIView *)customView;


/**
 *  文字
 *
 *  @param title
 *  @param style
 *  @param target
 *  @param action
 *  @param offsetX
 *
 *  @return
 */
+ (UIBarButtonItem * _Nullable)znt_makeLeftItemWithTitle:(nullable NSString *)title
                                                  color:(nullable UIColor *)color
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action;

+ (UIBarButtonItem * _Nullable)znt_makeRightItemWithTitle:(nullable NSString *)title
                                                   color:(nullable UIColor *)color
                                                  target:(nullable id)target
                                                  action:(nullable SEL)action;



/**
 *  图片
 *
 *  @param title
 *  @param style
 *  @param target
 *  @param action
 *  @param offsetX
 *
 *  @return
 */

+ (UIBarButtonItem * _Nullable)znt_makeItemWithImageName:(nullable NSString *)imageName
                                          highlightName:(nullable NSString *)highlightName
                                                offsetX:(CGFloat)offsetX
                                                 target:(nullable id)target
                                                 action:(nullable SEL)action;




+ (UIBarButtonItem * _Nullable)znt_makeLeftItemWithImageName:(nullable NSString *)imageName
                                              highlightName:(nullable NSString *)highlightName
                                                     target:(nullable id)target
                                                     action:(nullable SEL)action;



+ (UIBarButtonItem * _Nullable)znt_makeRightItemWithImageName:(nullable NSString *)imageName
                                              highlightName:(nullable NSString *)highlightName
                                                     target:(nullable id)target
                                                     action:(nullable SEL)action;



+ (CGFloat)znt_leftSecondItemOffsetX;
+ (CGFloat)znt_leftSecondImageOffsetX;
+ (CGFloat)znt_customViewDistance;

@end
