//
//  CLEditAddressViewController.h
//  Chinald
//
//  Created by WPFBob on 2018/4/11.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLTheGoodsAddressModel;
@interface CLEditAddressViewController : UIViewController
typedef NS_ENUM(NSInteger, AddressOperationType){
    CL_EDIT_ADDRESS_ADD = 0, //!<新增收货地址
    CL_EDIT_ADDRESS_EDIT //!<编辑收货地址
};
@property(nonatomic, strong)CLTheGoodsAddressModel *addressModel;  //!<
@property(nonatomic, assign)AddressOperationType addressOperationType;   //!<
@end
