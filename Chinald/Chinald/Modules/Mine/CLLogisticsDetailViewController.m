//
//  CLLogisticsDetailViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/6.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLLogisticsDetailViewController.h"
#import "CLLogisticsHistoryTableViewCell.h"
#import "CLLogisticsCompanyTableViewCell.h"
@interface CLLogisticsDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *logisticsTableView;

@end
@implementation CLLogisticsDetailViewController
static NSString *logisticsCompanyCellString = @"logisticsCompanyCell";
static NSString *logisticsHistoryCellString = @"logisticsHistoryCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    UIView *vLineView = [[UIView alloc]initWithFrame:CGRectMake(19, 164, 1, 4 * 74 - 3)];
    vLineView.backgroundColor = CLLineColor;
    [_logisticsTableView addSubview:vLineView];
    
    UIView *outView = [[UIView alloc] initWithFrame:CGRectMake(12, 149, 15, 15)];
    outView.backgroundColor = [UIColor clearColor];
    outView.layer.borderColor = [UIColor colorWithHexRGB:@"0x46C33B"].CGColor;
    outView.layer.borderWidth = 2;
    outView.layer.cornerRadius = 7.5;
    [_logisticsTableView addSubview:outView];
    UIView *inView = [[UIView alloc] initWithFrame:CGRectMake(16, 153, 7, 7)];
    inView.backgroundColor = [UIColor colorWithHexRGB:@"0x46C33B"];
    inView.layer.masksToBounds = YES;
    inView.layer.cornerRadius = 3.5;
    [_logisticsTableView addSubview:inView];
    
}


#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CLLogisticsCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logisticsCompanyCellString];
        if (!cell) {
            cell = [[CLLogisticsCompanyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logisticsCompanyCellString];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        CLLogisticsHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:logisticsHistoryCellString];
        if (!cell) {
            cell = [[CLLogisticsHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:logisticsHistoryCellString];
        }
        return cell;
    }

    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 70;
    //TODO 根据每条物流信息自适应高度
    return 75;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 45)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 76, 44)];
        titleLab.font = [UIFont zntFont14];
        titleLab.textColor = Color6;
        titleLab.text = @"运单编号";
        [view addSubview:titleLab];
        
        UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(88, 0, 220, 44)];
        numberLab.font = [UIFont zntFont14];
        numberLab.textColor = Color5;
        numberLab.text = @"995262257882";
        [view addSubview:numberLab];
        
        UIView *hLineView = [[UIView alloc]initWithFrame:CGRectMake(12, 43.5, ScreenFullWidth - 24, 0.5)];
        hLineView.backgroundColor = CLLineColor;
        [view addSubview:hLineView];
        return view;
    }
    return nil;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 10)];
        view.backgroundColor = CLVCBackgroundColor;
        return view;
    }
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 0.0001f;
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) return 10;
    return 0.0001f;
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
