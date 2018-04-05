//
//  CLToSendGoodsOperationItemView.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLToSendGoodsOperationItemView.h"

@implementation CLToSendGoodsOperationItemView
static int itemHeight = 28;
-(void)addItems{
    [super addItems];
    float itemY = (self.bounds.size.height - itemHeight) * 0.5;
    
    UIButton *refundButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 87,itemY, 75, itemHeight)];
    [refundButton setTitle:@"申请退款" forState:0];
    refundButton.titleLabel.font = [UIFont zntFont13];
    [refundButton setTitleColor:Color6 forState:0];
    refundButton.layer.borderWidth = 0.5;
    refundButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    refundButton.layer.cornerRadius = 2;
    refundButton.layer.masksToBounds = YES;
    [refundButton addTarget:self action:@selector(refundButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:refundButton];
}
-(void)refundButtonClick{
    if (self.orderToSendOperationItemClickBlock) {
        self.orderToSendOperationItemClickBlock(ORDER_SEND_REFUND,self.orderInfo);
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
