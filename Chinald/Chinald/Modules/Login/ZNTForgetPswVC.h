//
//  ZNTForgetPswVC.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/7.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNTUser.h"

@interface ZNTForgetPswVC : UIViewController

@property (nonatomic, strong) ZNTUser *user;

//是否从设置界面过来设置密码
@property (nonatomic, assign) BOOL isFromSettingVC;

INSTANCE_XIB_H

@end
