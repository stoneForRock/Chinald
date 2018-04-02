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
@implementation CLOrderCollectionViewCell
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
    vLineView.backgroundColor = [UIColor zntThemeTintColor];
    [view addSubview:vLineView];
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
    
    UIButton *buyAgainButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 91, 51, 79, 29)];
    [buyAgainButton setTitle:@"再次购买" forState:0];
    buyAgainButton.titleLabel.font = [UIFont zntFont13];
    [buyAgainButton setTitleColor:[UIColor zntThemeTintColor] forState:0];
    buyAgainButton.layer.borderWidth = 0.5;
    buyAgainButton.layer.borderColor = [UIColor zntThemeTintColor].CGColor;
    buyAgainButton.layer.cornerRadius = 2;
    buyAgainButton.layer.masksToBounds = YES;
    [view addSubview:buyAgainButton];
    
    UIButton *assessButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 180, 51, 79, 29)];
    [assessButton setTitle:@"评价" forState:0];
    [assessButton setTitleColor:Color5 forState:0];
    assessButton.titleLabel.font = [UIFont zntFont13];
    
    assessButton.layer.borderWidth = 0.5;
    assessButton.layer.borderColor = [UIColor colorWithHexRGB:@"0xD9D9D9"].CGColor;
    assessButton.layer.cornerRadius = 2;
    assessButton.layer.masksToBounds = YES;
    [view addSubview:assessButton];
    
    UIButton *seeWuLiuButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenFullWidth - 269, 51, 79, 29)];
    [seeWuLiuButton setTitle:@"查看物流" forState:0];
    [seeWuLiuButton setTitleColor:Color5 forState:0];
    seeWuLiuButton.titleLabel.font = [UIFont zntFont13];
    seeWuLiuButton.layer.borderWidth = 0.5;
    seeWuLiuButton.layer.borderColor = [UIColor colorWithHexRGB:@"0xD9D9D9"].CGColor;
    seeWuLiuButton.layer.cornerRadius = 2;
    seeWuLiuButton.layer.masksToBounds = YES;
    [view addSubview:seeWuLiuButton];
    return backgroundView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 102;
}
@end
