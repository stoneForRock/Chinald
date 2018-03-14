//
//  UIView+DZCategory.h
//  kdweibo
//
//  Created by Darren Zheng on 15/11/10.
//  Copyright © 2015年 www.kingdee.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DZCategory)
/**
 *  用来处理scroll to top失效的问题
 *  该方法关闭了所有子view的scroll to top
 *  via http://stackoverflow.com/questions/4167806/automatic-scroll-to-top-doesnt-work-in-uitableview
 */
- (void)disableScrollsToTopPropertyOnAllSubviews;
- (void)showToast:(NSString *)text duration:(double)duration;

- (void)showDebugFrame;

- (void)dimm;
@end
