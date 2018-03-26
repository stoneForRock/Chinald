//
//  ZNTTabBarController.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTTabBarController.h"
#import "CLMainPageVC.h"
#import "CLShoppingCartVC.h"
#import "CLMineVC.h"

@implementation UITabBar (ZNTAdd)

//- (void)rotation {
//    CGFloat width = 0;
//    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
//        width = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
//    }
//    else {
//        width = MAX(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
//    }
//    for (int i = 0; i < [self.items count]; i++) {
//        UIView *badgeView = [self hasBadgeValueViewAtIndex:i];
//        if (badgeView) {
//            CGFloat x = ((float)(1 + 2 * i) / ([self.items count] * 2)) * width + 8;
//            CGFloat y = 0.1 * CGRectGetHeight(self.frame);
//            badgeView.frame = CGRectMake(x, y, CGRectGetWidth(badgeView.frame), CGRectGetHeight(badgeView.frame));
//        }
//        UIView *dotView = [self hasDotViewAtIndex:i];
//        if (dotView) {
//            CGFloat x = ((float)(1 + 2 * i) / ([self.items count] * 2)) * width + 8;
//            CGFloat y = 0.1 * CGRectGetHeight(self.frame);
//            dotView.frame = CGRectMake(x, y, 9, 9);
//        }
//    }
//}

- (void)setBadgeValue:(int)badgeValue atIndex:(NSInteger)index {
    UITabBarItem *item = [self.items objectAtIndex:index];
    item.badgeValue = (badgeValue <= 0)?@" ":[NSString stringWithFormat:@"%d",badgeValue];
    UILabel *badgeValueView = [self badgeValueViewAtIndex:index];
    badgeValueView.hidden = (badgeValue <= 0);
    if (!badgeValueView.hidden) {
        [self setupBadgeValueView:badgeValueView unreadCount:badgeValue atIndex:index];
    }
}

- (UILabel *)badgeValueViewAtIndex:(NSInteger)index {
    NSInteger tag = 999999 + index;
    UILabel *badgeValueView = (UILabel *)[self viewWithTag:tag];
    if (!badgeValueView) {
        badgeValueView  = [[UILabel alloc] init];
        badgeValueView.backgroundColor = [UIColor redColor];
        badgeValueView.layer.cornerRadius = 2.0;
        badgeValueView.layer.masksToBounds = YES;
        badgeValueView.bounds = CGRectMake(0, 0, 4, 4);
        badgeValueView.tag = tag;
        badgeValueView.hidden = YES;
        [self addSubview:badgeValueView];
    }
    return badgeValueView;
}

- (void)setupBadgeValueView:(UILabel *)badgeValueView
                unreadCount:(int)unreadCount
                    atIndex:(NSInteger)index {
    badgeValueView.text = [NSString stringWithFormat:@"%d",unreadCount];
    CGFloat x = ((float)(1 + 2 * index) / ([self.items count] * 2)) * CGRectGetWidth(self.frame) + 8;
    CGFloat y = 0.1 * CGRectGetHeight(self.frame);
    badgeValueView.frame = CGRectMake(x, y, CGRectGetWidth(badgeValueView.frame), CGRectGetHeight(badgeValueView.frame));
}

- (void)setDotHidden:(BOOL)hidden atIndex:(NSInteger)index {
//    UITabBarItem *item = [self.items objectAtIndex:index];
//    item.badgeValue = @" ";
    UIView *dotView = [self dotViewAtIndex:index];
    dotView.hidden = hidden;
}

- (UIView *)dotViewAtIndex:(NSInteger)index {
    
    NSInteger tag = 9999 + index;
    UIView *dotView = [self viewWithTag:tag];
    if (!dotView) {
        //初始化小红点
//        dotView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_img_new"]];
        dotView  = [[UIView alloc] init];
        dotView.layer.cornerRadius = 2;
        dotView.layer.masksToBounds = YES;
        dotView.backgroundColor = [UIColor redColor];
        dotView.tag = tag;
        dotView.hidden = YES;
        [self addSubview:dotView];
        
        CGFloat x = ((float)(1 + 2 * index) / ([self.items count] * 2)) * CGRectGetWidth(self.frame) + 8;
        CGFloat y = 0.2 * CGRectGetHeight(self.frame);
        dotView.frame = CGRectMake(x, y, 4, 4);
    }
    return dotView;
}

//- (UIView *)hasDotViewAtIndex:(NSInteger)index {
//    NSInteger tag = 9999 + index;
//    UIView *dotView = [self viewWithTag:tag];
//    return dotView;
//}

@end

@interface ZNTTabBarController () <UITabBarControllerDelegate>
@property (assign, nonatomic) int tapCount;
@property (strong, nonatomic) UILabel *lineLabel;
@property (weak, nonatomic) UIViewController *previousHandledViewController;
@end

@implementation ZNTTabBarController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        self.view.backgroundColor = ThemeBacgroundColor;
        self.tabBar.itemPositioning = UITabBarItemPositioningFill;
        if ([UIDevice isiPadDevice]) {
            [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(orientationChanged:) name: UIDeviceOrientationDidChangeNotification object: nil];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.clipsToBounds = YES;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithRGB:0xDBE5ED];
    [self.tabBar addSubview:line];
    
    [self.tabBar setBackgroundImage:[UIImage znt_imageWithColor:ThemeBacgroundColor]];
    
    [self refreshUnReadCount];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUnReadCount) name:kNFRefreshNotiMsg object:nil];
}

- (void)refreshUnReadCount {
//    UITabBarItem * item=[self.tabBar.items objectAtIndex:2];
//    NSInteger unreadCount = 0;
//    item.badgeValue = [NSString stringWithFormat:@"%ld",(long)unreadCount];
    
//    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    [self refreshUnReadCount];
}

#pragma mark - UITabBarControllerDelegate -

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    self.tapCount++;
    
    BOOL hasTappedTwiceOnOneTab = NO;
    if (self.previousHandledViewController == viewController) {
        hasTappedTwiceOnOneTab = YES;
    }
    self.previousHandledViewController = viewController;
    
    CGFloat tapTimeRange = 0.3;
    if (self.tapCount == 2 && hasTappedTwiceOnOneTab) {
        // do something when tapped twice
        UIViewController <ZNTTabBarControllerDelegate> *vc = nil;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            vc = (UIViewController <ZNTTabBarControllerDelegate> *)[[(RTRootNavigationController *)viewController viewControllers] firstObject];
        }
        UIViewController <ZNTTabBarControllerDelegate> *controller = [(RTContainerController *)vc contentViewController];
        if (!controller) return NO;
        if (controller && [controller respondsToSelector:@selector(tabBarSelectedTwice)]) {
            [NSObject cancelPreviousPerformRequestsWithTarget:controller];
            [controller tabBarSelectedTwice];
        }
        
        self.tapCount = 0;
        return NO;
    }
    else if (self.tapCount == 1) {
        BOOL isSameViewControllerSelected = tabBarController.selectedViewController == viewController;
        if (isSameViewControllerSelected) {
            // do something when tapped once
            UIViewController <ZNTTabBarControllerDelegate> *vc = nil;
            if ([viewController isKindOfClass:[UINavigationController class]]) {
                vc = (UIViewController <ZNTTabBarControllerDelegate> *)[[(RTRootNavigationController *)viewController viewControllers] firstObject];
            }
            UIViewController <ZNTTabBarControllerDelegate> *controller = [(RTContainerController *)vc contentViewController];
            if (!controller) return NO;
            if (controller && [controller respondsToSelector:@selector(tabBarSelectedOnce)]) {
                [controller performSelector:@selector(tabBarSelectedOnce) withObject:nil afterDelay:tapTimeRange];
            }
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(tapTimeRange * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.tapCount = 0;
        });
    }
    
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //这里有个问题，双击的时候会重复统计两次
    
    if([[(UINavigationController *)viewController topViewController] isMemberOfClass:[CLMainPageVC class]] || [[(UINavigationController *)viewController topViewController] isMemberOfClass:[CLShoppingCartVC class]] || [[(UINavigationController *)viewController topViewController] isMemberOfClass:[CLMineVC class]])
    {
        [[(UINavigationController *)viewController topViewController] setNavigationStyle:ZNTNavigationStyleBlue];
    }
    else
    {
        [(UINavigationController *)tabBarController.selectedViewController popToRootViewControllerAnimated:NO];
    }
    
}

- (void)orientationChanged:(NSNotification *)note  {
    if ([UIDevice isiPadDevice]) {
//        [self.tabBar rotation];
    }
}

@end
