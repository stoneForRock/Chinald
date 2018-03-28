//
//  CLMainPageVC.m
//  Chinald
//
//  Created by shichuang on 2018/3/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMainPageVC.h"
#import "CLMainPageRequest.h"
#import "UnlimitedScrollView.h"
#import "CLMainPageListModel.h"

@interface CLMainPageVC ()<UINavigationControllerDelegate, UnlimitedScrollViewDelegate>

@property (nonatomic, strong) UnlimitedScrollView *adScrollView;

@end

@implementation CLMainPageVC

INSTANCE_XIB_M(@"MainPage", CLMainPageVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initDataInfo];
    
    [self requestMainPageData];
    
    // Do any additional setup after loading the view.
}

- (void)initUI {
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initDataInfo {
    self.navigationController.delegate = self;
}

- (void)requestMainPageData {
    
}


//隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    RTContainerController *currentController = (RTContainerController *)viewController;
    BOOL isShowHomePage = [currentController.contentViewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:animated];
}

#pragma mark - delegate

- (void)clickWithPage:(NSInteger)intPage view:(UnlimitedScrollView *)unlimitedScrollView {
    
}

#pragma mark - setter&&getter

- (UnlimitedScrollView *)adScrollView {
    if (!_adScrollView) {
        _adScrollView = [[UnlimitedScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 165)];
        _adScrollView.delegate = self;
    }
    return _adScrollView;
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
