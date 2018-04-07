//
//  CLOrderOperationItem.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderOperationItem.h"
#import "CLOrderOperationItemViewBase.h"
#import "CLForPaymentOperationItemView.h"
#import "CLToSendGoodsOperationItemView.h"
#import "CLWaitingForGoodsOperationItemView.h"
#import "CLReceivedOperationItemView.h"
#import "CLAfterSalesOperationItemView.h"
@implementation CLOrderOperationItem
+(CLOrderOperationItemViewBase *)showOrderOperationItemWithFrame:(CGRect)frame pullMenuViewType:(OrderOperationType)type theOrder:(id)orderInfo{
    if (type == CL_FOR_PAY_OPERATION) {
        CLOrderOperationItemViewBase *viewBase = [[CLForPaymentOperationItemView alloc]initWithFrame:frame];
        viewBase.orderInfo = orderInfo;
        return viewBase;
    }
    if (type == CL_TO_SEND_OPERATION) {
        CLOrderOperationItemViewBase *viewBase = [[CLToSendGoodsOperationItemView alloc]initWithFrame:frame];
        viewBase.orderInfo = orderInfo;
        return viewBase;
    }
    if (type == CL_WATITING_GOODS_OPERATION) {
        CLOrderOperationItemViewBase *viewBase = [[CLWaitingForGoodsOperationItemView alloc]initWithFrame:frame];
        viewBase.orderInfo = orderInfo;
        return viewBase;
    }
    if (type == CL_RECEIVED_OPERATION) {
        CLOrderOperationItemViewBase *viewBase = [[CLReceivedOperationItemView alloc]initWithFrame:frame];
        viewBase.orderInfo = orderInfo;
        return viewBase;
    }
    if (type == CL_AFTER_SALES_OPERATION) {
        CLOrderOperationItemViewBase *viewBase = [[CLAfterSalesOperationItemView alloc]initWithFrame:frame];
        viewBase.orderInfo = orderInfo;
        return viewBase;
    }
    return nil;
}
@end
