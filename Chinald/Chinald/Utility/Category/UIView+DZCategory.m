//
//  UIView+DZCategory.m
//  kdweibo
//
//  Created by Darren Zheng on 15/11/10.
//  Copyright © 2015年 www.kingdee.com. All rights reserved.
//

#import "UIView+DZCategory.h"

@implementation UIView (DZCategory)

- (void)disableScrollsToTopPropertyOnAllSubviews
{
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UIScrollView class]])
        {
            ((UIScrollView *)subview).scrollsToTop = NO;
        }
        [subview disableScrollsToTopPropertyOnAllSubviews];
    }
}

- (void)dimm {
    self.alpha = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.alpha = 1;
    });
}

- (void)showToast:(NSString *)text duration:(double)duration {
    if (text.length == 0 || duration == 0) {
        return;
    }
}

- (void)showDebugFrame
{
#if DEBUG
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 0.5f;
    
#endif
}
@end
