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
@interface CLOrderDetailViewController ()
@property(nonatomic, strong)UITableView *orderDetailTableView;  //!<
@end

@implementation CLOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addTableViewAndOperationItems];
}
-(void)addTableViewAndOperationItems{

    
    CGRect tableViewRect = CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight - 49);

    _orderDetailTableView = [[UITableView alloc]initWithFrame:tableViewRect style:UITableViewStylePlain];
    [self.view addSubview:_orderDetailTableView];
    
    
    
    CGRect orderOperationItemViewRect = CGRectMake(0, _orderDetailTableView.bounds.size.height, ScreenFullWidth, 49);
    CLOrderOperationItemViewBase *orderOperationItemView = [CLOrderOperationItem showOrderOperationItemWithFrame:orderOperationItemViewRect pullMenuViewType:CL_FOR_PAY_OPERATION theOrder:nil];
    [self.view addSubview:orderOperationItemView];
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
