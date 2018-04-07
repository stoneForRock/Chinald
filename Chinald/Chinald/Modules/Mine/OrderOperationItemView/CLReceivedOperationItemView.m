//
//  CLReceivedOperationItemView.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLReceivedOperationItemView.h"

@implementation CLReceivedOperationItemView
static int itemHeight = 28;
-(void)addItems{
    [super addItems];
    float itemY = (self.bounds.size.height - itemHeight) * 0.5;
    
    UIButton *evaluationButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 87,itemY, 75, itemHeight)];
    [evaluationButton setTitle:@"评价" forState:0];
    evaluationButton.titleLabel.font = [UIFont zntFont13];
    [evaluationButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
    evaluationButton.layer.borderWidth = 0.5;
    evaluationButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
    evaluationButton.layer.cornerRadius = 2;
    evaluationButton.layer.masksToBounds = YES;
    [evaluationButton addTarget:self action:@selector(evaluationButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:evaluationButton];
    
    UIButton *lookLogisticsButton = [[UIButton alloc]initWithFrame:CGRectMake(evaluationButton.frame.origin.x - 85,itemY, 75, itemHeight)];
    [lookLogisticsButton setTitle:@"查看物流" forState:0];
    lookLogisticsButton.titleLabel.font = [UIFont zntFont13];
    [lookLogisticsButton setTitleColor:Color6 forState:0];
    lookLogisticsButton.layer.borderWidth = 0.5;
    lookLogisticsButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    lookLogisticsButton.layer.cornerRadius = 2;
    lookLogisticsButton.layer.masksToBounds = YES;
    [evaluationButton addTarget:self action:@selector(lookLogisticsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lookLogisticsButton];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(lookLogisticsButton.frame.origin.x - 85,itemY, 75, itemHeight)];
    [deleteButton setTitle:@"删除订单" forState:0];
    deleteButton.titleLabel.font = [UIFont zntFont13];
    [deleteButton setTitleColor:Color6 forState:0];
    deleteButton.layer.borderWidth = 0.5;
    deleteButton.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    deleteButton.layer.cornerRadius = 2;
    deleteButton.layer.masksToBounds = YES;
    [evaluationButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
}
-(void)evaluationButtonClick{
    if (self.orderReceiveOperationItemClickBlock) {
        self.orderReceiveOperationItemClickBlock(ORDER_RECEIVED_EVALUATION,self.orderInfo);
    }
}
-(void)lookLogisticsButtonClick{
    if (self.orderReceiveOperationItemClickBlock) {
        self.orderReceiveOperationItemClickBlock(ORDER_RECEIVED_LOGISTICS,self.orderInfo);
    }
}
-(void)deleteButtonClick{
    if (self.orderReceiveOperationItemClickBlock) {
        self.orderReceiveOperationItemClickBlock(ORDER_RECEIVED_DELETE,self.orderInfo);
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
