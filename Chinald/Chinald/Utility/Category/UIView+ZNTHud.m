//
//  UIView+ZNTHud.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UIView+ZNTHud.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIView (ZNTHud)


- (void)znt_showHUD:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = text;
}

- (void)znt_hideHUD
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)znt_showToast:(NSString *)text
{
    [self znt_showToast:text afterDelay:kHudDefaultDuration];
}

- (void)znt_showToast:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.color = [UIColor blackColor];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = kHudDefaultFont;
    hud.userInteractionEnabled = NO;    //can touch while show toast
    [hud hideAnimated:YES afterDelay:delay];
}

- (void)znt_showImageToast:(NSString *)text imageName:(NSString *)imageName {
    [self znt_showImageToast:text imageName:imageName afterDelay:kHudDefaultDuration];
}

- (void)znt_showImageToast:(NSString *)text imageName:(NSString *)imageName afterDelay:(NSTimeInterval)delay {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    hud.bezelView.color = [UIColor blackColor];
    hud.label.text = text;
    hud.label.font = kHudDefaultFont;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:delay];
}


@end
