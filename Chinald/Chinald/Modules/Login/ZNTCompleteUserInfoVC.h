//
//  ZNTCompleteUserInfoVC.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/7.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNTUser.h"

@interface ZNTCompleteUserInfoVC : UIViewController

@property (nonatomic, strong) ZNTUser *user;

//验证码
@property (nonatomic, strong) NSString *code;

INSTANCE_XIB_H

@end
