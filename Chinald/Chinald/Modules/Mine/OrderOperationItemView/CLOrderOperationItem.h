//
//  CLOrderOperationItem.h
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLOrderOperationItemViewBase;
@interface CLOrderOperationItem : NSObject
typedef NS_ENUM(NSInteger, OrderOperationType){
    CL_FOR_PAY_OPERATION = 0, //!<待付款的操作
    CL_TO_SEND_OPERATION, //!<待发货的操作
    CL_WATITING_GOODS_OPERATION,//!<待收货
    CL_RECEIVED_OPERATION,//!<已收货
    CL_AFTER_SALES_OPERATION//!<售后
};
@property(nonatomic, readwrite)OrderOperationType orderOperationType;
+(CLOrderOperationItemViewBase *)showOrderOperationItemWithFrame:(CGRect)frame pullMenuViewType:(OrderOperationType)type theOrder:(id)orderInfo;

@end
