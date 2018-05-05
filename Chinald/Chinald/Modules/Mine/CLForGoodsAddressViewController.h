//
//  CLForGoodsAddressViewController.h
//  Chinald
//
//  Created by WPFBob on 2018/4/10.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLTheGoodsAddressModel;
@interface CLForGoodsAddressViewController : UIViewController
@property(nonatomic, strong)void(^selectAddressBlock)(CLTheGoodsAddressModel *addressModel);  //!<

@end
