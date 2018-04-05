//
//  CLForPaymentOperationItemView.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLForPaymentOperationItemView.h"

@implementation CLForPaymentOperationItemView
static int itemHeight = 28;
-(void)addItems{
    [super addItems];
    float itemY = (self.bounds.size.height - itemHeight) * 0.5;
    
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 87,itemY, 75, itemHeight)];
    [payButton setTitle:@"立即付款" forState:0];
    payButton.titleLabel.font = [UIFont zntFont13];
    [payButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
    payButton.layer.borderWidth = 0.5;
    payButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
    payButton.layer.cornerRadius = 2;
    payButton.layer.masksToBounds = YES;
    [payButton addTarget:self action:@selector(payButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:payButton];
    
    UIButton *cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(payButton.frame.origin.x - 85,itemY, 75, itemHeight)];
    [cancleButton setTitle:@"取消订单" forState:0];
    cancleButton.titleLabel.font = [UIFont zntFont13];
    [cancleButton setTitleColor:Color6 forState:0];
    cancleButton.layer.borderWidth = 0.5;
    cancleButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    cancleButton.layer.cornerRadius = 2;
    cancleButton.layer.masksToBounds = YES;
    [cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:cancleButton];
}
-(void)cancleButtonClick{
    if (self.orderForPayOperationItemClickBlock) {
        self.orderForPayOperationItemClickBlock(ORDER_PAY_CANCEL,self.orderInfo);
    }
}
-(void)payButtonClick{
    if (self.orderForPayOperationItemClickBlock) {
        self.orderForPayOperationItemClickBlock(ORDER_PAY_PAY,self.orderInfo);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
