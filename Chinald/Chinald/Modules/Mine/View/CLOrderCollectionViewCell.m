//
//  CLOrderCollectionViewCell.m
//  Chinald
//
//  Created by WPFBob on 2018/4/1.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderCollectionViewCell.h"
#import "CLOrderTableViewCell.h"
#import "CLDottedLineView.h"
#import "NSString+DZCategory.h"
#import "CLOrderOperationItem.h"
#import "CLOrderOperationItemViewBase.h"
@interface CLOrderCollectionViewCell()
@property (strong, nonatomic) IBOutlet UITableView *orderListTableView;

@end
@implementation CLOrderCollectionViewCell
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.orderListTableView reloadData];
}
#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *orderTableViewCellString = @"orderTableViewCell";
    CLOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderTableViewCellString forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderTableViewCellString];
    }
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 43)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    //订单编号
    UILabel *orderNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, 200, 43)];
    orderNumberLabel.text = @"订单编号：16020290809011";
    orderNumberLabel.font = [UIFont zntFont14];
    orderNumberLabel.textColor = Color5;
    [view addSubview:orderNumberLabel];
    
    //订单状态
    UILabel *orderStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenFullWidth - 80, 0, 67, 43)];
    orderStatusLabel.text = @"退款成功";
    orderStatusLabel.font = [UIFont zntFont14];
    orderStatusLabel.textColor = Color5;
    orderStatusLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:orderStatusLabel];
    
    UIView *vLineView = [[UIView alloc]initWithFrame:CGRectMake(12, 42.5, ScreenFullWidth - 24, 0.5)];
    vLineView.backgroundColor = CLLineColor;
    [view addSubview:vLineView];
    
    UIButton *headerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 43)];
    headerButton.backgroundColor = [UIColor clearColor];
    //使用button记录订单编号、id
    [headerButton setTitle:@"" forState:0];
    [headerButton addTarget:self action:@selector(headerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:headerButton];
    return view;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor zntThemeTintColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    //    if (section == 0) return 0.0001f;
    
    return 43;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 102)];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 92)];
    
    view.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:view];
    
    NSString *payLabelString = @"实付 ￥109.00";
    float payLabelWidth = [payLabelString kd_sizeWithFont:[UIFont zntFont14]].width;
    UILabel *payLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenFullWidth - payLabelWidth - 12, 6, payLabelWidth, 15)];
    payLabel.textAlignment = NSTextAlignmentRight;
    payLabel.textColor = Color5;
    payLabel.font = [UIFont zntFont14];
    payLabel.text = @"实付 ￥109.00";
    [view addSubview:payLabel];
    
    UILabel *goodsCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 6, ScreenFullWidth - payLabelWidth - 34, 15)];
    goodsCountLabel.textAlignment = NSTextAlignmentRight;
    goodsCountLabel.textColor = Color5;
    goodsCountLabel.font = [UIFont zntFont14];
    goodsCountLabel.text = @"共13件商品";
    [view addSubview:goodsCountLabel];
    CLDottedLineView *dottedLineView = [[CLDottedLineView alloc]initWithFrame:CGRectMake(13, 36, ScreenFullWidth - 26, 1)];
    [view addSubview:dottedLineView];
    CLOrderOperationItemViewBase *orderOperationItemView = [CLOrderOperationItem showOrderOperationItemWithFrame:CGRectMake(0, dottedLineView.frame.origin.y + dottedLineView.frame.size.height, ScreenFullWidth, 55) pullMenuViewType:CL_FOR_PAY_OPERATION theOrder:nil];
    [view addSubview:orderOperationItemView];

    return backgroundView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 102;
}

//查看订单详情，将订单详情的数据返回
-(void)headerButtonClick:(UIButton *)button{
    if (self.orderCellClickBlock) {
        self.orderCellClickBlock(nil);
    }
}
@end
