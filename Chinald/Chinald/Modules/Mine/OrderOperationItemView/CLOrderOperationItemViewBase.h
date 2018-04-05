//
//  CLOrderOperationItemViewBase.h
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLOrderOperationItemViewBase : UIView
typedef NS_ENUM(NSInteger, OrderForPayOperationType){
    ORDER_PAY_CANCEL,
    ORDER_PAY_PAY
};
typedef NS_ENUM(NSInteger, OrderToSendOperationType){
    ORDER_SEND_REFUND
};
typedef NS_ENUM(NSInteger, OrderWaitingForGoodsOperationType){
    ORDER_WAITING_REFUND,
    ORDER_WAITING_LOGISTICS,
    ORDER_WAITING_ENTER
    
};
typedef NS_ENUM(NSInteger, OrderReceivedOperationType){
    ORDER_RECEIVED_DELETE,
    ORDER_RECEIVED_LOGISTICS,
    ORDER_RECEIVED_EVALUATION
};
typedef NS_ENUM(NSInteger, OrderAfterSalesOperationType){
    ORDER_AFTER_ASLES_REFUND
};
@property(nonatomic, strong)id orderInfo;  //!<
@property (copy, nonatomic)void(^orderForPayOperationItemClickBlock)(OrderForPayOperationType operationType,id orderInfo);
@property (copy, nonatomic)void(^orderToSendOperationItemClickBlock)(OrderToSendOperationType operationType,id orderInfo);
@property (copy, nonatomic)void(^orderWaitingForGoodsOperationItemClickBlock)(OrderWaitingForGoodsOperationType operationType,id orderInfo);
@property (copy, nonatomic)void(^orderReceiveOperationItemClickBlock)(OrderReceivedOperationType operationType,id orderInfo);
@property (copy, nonatomic)void(^orderAfterSalesOperationItemClickBlock)(OrderAfterSalesOperationType operationType,id orderInfo);
-(instancetype)initWithFrame:(CGRect)frame;

//添加子视图
-(void)addItems;
@end
