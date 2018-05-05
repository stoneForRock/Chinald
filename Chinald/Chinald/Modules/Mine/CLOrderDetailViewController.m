//
//  CLOrderDetailViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderDetailViewController.h"
#import "CLOrderOperationItem.h"
#import "CLOrderOperationItemViewBase.h"
#import "CLOrderStatusTableViewCell.h"
#import "CLOrderInfoTableViewCell.h"
#import "CLOrderCostDetailTableViewCell.h"
#import "CLOrderGoodsTableViewCell.h"
@interface CLOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *orderDetailTableView;  //!<
@end

@implementation CLOrderDetailViewController
static NSString *orderStatusTableViewCellString = @"orderStatusTableViewCell";
static NSString *orderInfoTableViewCellString = @"orderInfoTableViewCell";
static NSString *orderCostDetailTableViewCellString = @"orderCostDetailTableViewCell";
static NSString *orderGoodsTableViewCellString = @"orderGoodsTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)){
        _orderDetailTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationItem.title = @"订单详情";
    // Do any additional setup after loading the view.
    [self addTableViewAndOperationItems];
}
-(void)addTableViewAndOperationItems{

    
    CGRect tableViewRect = CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight - 49 - 64);

    _orderDetailTableView = [[UITableView alloc]initWithFrame:tableViewRect style:UITableViewStyleGrouped];
    _orderDetailTableView.delegate = self;
    _orderDetailTableView.dataSource = self;
    _orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_orderDetailTableView];
    [_orderDetailTableView registerClass:[CLOrderGoodsTableViewCell class] forCellReuseIdentifier:orderGoodsTableViewCellString];
    [_orderDetailTableView registerClass:[CLOrderCostDetailTableViewCell class] forCellReuseIdentifier:orderCostDetailTableViewCellString];
    [_orderDetailTableView registerClass:[CLOrderInfoTableViewCell class] forCellReuseIdentifier:orderInfoTableViewCellString];
    [_orderDetailTableView registerClass:[CLOrderStatusTableViewCell class] forCellReuseIdentifier:orderStatusTableViewCellString];

    
    CGRect orderOperationItemViewRect = CGRectMake(0, ScreenFullHeight - 49 - 64, ScreenFullWidth, 49);
    CLOrderOperationItemViewBase *orderOperationItemView = [CLOrderOperationItem showOrderOperationItemWithFrame:orderOperationItemViewRect pullMenuViewType:CL_WATITING_GOODS_OPERATION theOrder:nil];
    [self.view addSubview:orderOperationItemView];
    orderOperationItemView.orderWaitingForGoodsOperationItemClickBlock = ^(OrderWaitingForGoodsOperationType operationType, id orderInfo) {
        if (operationType == ORDER_WAITING_LOGISTICS) {
            [self performSegueWithIdentifier:@"orderDetailvcToLogisticsDetailVC" sender:nil];
        }
        if (operationType == ORDER_WAITING_REFUND) {
            [self performSegueWithIdentifier:@"orderDetailVCToRefundVC" sender:nil];
        }
    };
}

#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 2 || section == 3) {
        return 1;
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        CLOrderStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderStatusTableViewCellString];
        if (!cell) {
            cell = [[CLOrderStatusTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderStatusTableViewCellString];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        CLOrderGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderGoodsTableViewCellString];
        if (!cell) {
            cell = [[CLOrderGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderGoodsTableViewCellString];
        }
        return cell;
    }
    if (indexPath.section == 2) {
        CLOrderCostDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCostDetailTableViewCellString];
        if (!cell) {
            cell = [[CLOrderCostDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCostDetailTableViewCellString];
        }
        return cell;
    }
    if (indexPath.section == 3) {
        CLOrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderInfoTableViewCellString];
        if (!cell) {
            cell = [[CLOrderInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderInfoTableViewCellString];
        }
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 138;
    if (indexPath.section == 1) return 110;
    if (indexPath.section == 2) return 132;
    return 116;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 45)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 200, 45)];
        lab.font = [UIFont zntFont15];
        lab.textColor = Color5;
        
        lab.text = @[@"",@"商品清单",@"费用明细",@"订单信息"][section];
        
        [view addSubview:lab];
        
        return view;
    }
    return nil;

}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor zntThemeTintColor];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 0.0001f;
    if (section == 1 || section == 2 || section == 3) return 45;
    return 0.0001f;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 102)];
//
//    return backgroundView;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
