//
//  CLWaitingForGoodsOperationItemView.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLWaitingForGoodsOperationItemView.h"

@implementation CLWaitingForGoodsOperationItemView
static int itemHeight = 28;
-(void)addItems{
    [super addItems];
    float itemY = (self.bounds.size.height - itemHeight) * 0.5;
    
    UIButton *enterButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 87,itemY, 75, itemHeight)];
    [enterButton setTitle:@"确认收货" forState:0];
    enterButton.titleLabel.font = [UIFont zntFont13];
    [enterButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
    enterButton.layer.borderWidth = 0.5;
    enterButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
    enterButton.layer.cornerRadius = 2;
    enterButton.layer.masksToBounds = YES;
    [enterButton addTarget:self action:@selector(enterButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:enterButton];
    
    UIButton *lookLogisticsButton = [[UIButton alloc]initWithFrame:CGRectMake(enterButton.frame.origin.x - 85,itemY, 75, itemHeight)];
    [lookLogisticsButton setTitle:@"查看物流" forState:0];
    lookLogisticsButton.titleLabel.font = [UIFont zntFont13];
    [lookLogisticsButton setTitleColor:Color6 forState:0];
    lookLogisticsButton.layer.borderWidth = 0.5;
    lookLogisticsButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    lookLogisticsButton.layer.cornerRadius = 2;
    lookLogisticsButton.layer.masksToBounds = YES;
    [lookLogisticsButton addTarget:self action:@selector(lookLogisticsButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:lookLogisticsButton];
    
    UIButton *refundButton = [[UIButton alloc]initWithFrame:CGRectMake(lookLogisticsButton.frame.origin.x - 85,itemY, 75, itemHeight)];
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
    if (self.orderWaitingForGoodsOperationItemClickBlock) {
        self.orderWaitingForGoodsOperationItemClickBlock(ORDER_WAITING_REFUND,self.orderInfo);
    }
}
-(void)enterButtonClick{
    if (self.orderWaitingForGoodsOperationItemClickBlock) {
        self.orderWaitingForGoodsOperationItemClickBlock(ORDER_WAITING_ENTER,self.orderInfo);
    }
}
-(void)lookLogisticsButtonClick{
    if (self.orderWaitingForGoodsOperationItemClickBlock) {
        self.orderWaitingForGoodsOperationItemClickBlock(ORDER_WAITING_LOGISTICS,self.orderInfo);
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
