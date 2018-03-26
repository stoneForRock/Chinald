//
//  CLShoppingCartVC.m
//  Chinald
//
//  Created by shichuang on 2018/3/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLShoppingCartVC.h"

@interface CLShoppingCartVC ()

@end

@implementation CLShoppingCartVC

INSTANCE_XIB_M(@"ShoppingCart", CLShoppingCartVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initDataInfo];
    
    [self requestMainPageData];
    
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initDataInfo {
    
}

- (void)requestMainPageData {
    
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
