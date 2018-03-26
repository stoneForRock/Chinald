//
//  CLMineVC.m
//  Chinald
//
//  Created by shichuang on 2018/3/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineVC.h"

@interface CLMineVC ()

@end

@implementation CLMineVC

INSTANCE_XIB_M(@"Mine", CLMineVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initDataInfo];
    
    [self requestData];
    
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initDataInfo {
    
}

- (void)requestData {
    
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
