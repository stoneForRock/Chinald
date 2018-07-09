//
//  CLAddressTableViewCell.h
//  Chinald
//
//  Created by WPFBob on 2018/4/10.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTheGoodsAddressModel.h"
@interface CLAddressTableViewCell : UITableViewCell
typedef NS_ENUM(NSInteger, ForGoodsAddressOperationType){
    CL_ADDRESS_DEFAULT = 0, //!<设置收货地址为默认收货地址
    CL_ADDRESS_EDIT, //!<编辑收货地址
    CL_ADDRESS_DELETE//!<删除收货地址
};
@property(nonatomic, strong)CLTheGoodsAddressModel *goodsAddressModel;  //!<收货地址的Model
@property(nonatomic, strong)void(^selectForGoodsAddresCellBlock)(ForGoodsAddressOperationType forGoodsAddressOperationType,CLTheGoodsAddressModel *addressModel);  //!<
@end
