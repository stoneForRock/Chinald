//
//  CLMineVC.m
//  Chinald
//
//  Created by shichuang on 2018/3/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineVC.h"
#import "CLMineOrderAboutTableViewCell.h"
#import "CLMineShareTableViewCell.h"
#import "CLMineAccountInfoTableViewCell.h"
@interface CLMineVC ()
@property (strong, nonatomic) IBOutlet UITableView *mineTableView;
@property(nonatomic, strong) NSArray *cellTitleStringArray; //!<
@end

@implementation CLMineVC
static NSString *accountInfoCellString = @"CLMineAccountInfoTableViewCell";
static NSString *orderAboutTableViewCellString = @"CLMineOrderAboutTableViewCell";
static NSString *shareTableViewCellString = @"CLMineShareTableViewCell";

static NSString *otherTableViewCellString = @"CLMineOtherTableViewCell";

INSTANCE_XIB_M(@"Mine", CLMineVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    
    if (kiOS10Later){
//        _mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //    self.title = @"个人中心";
    _cellTitleStringArray = @[@[@""],@[@"我的订单",@""],@[@""],@[@"关于我们",@"我要吐槽",@"APP设置"]];
    [_mineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:otherTableViewCellString];
    [_mineTableView registerClass:[CLMineAccountInfoTableViewCell class] forCellReuseIdentifier:accountInfoCellString];
    
}

#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (section == 0) return 1;
    //    if (section == 1) return 2;
    //    if (section == 2) return 1;
    //    if (section == 3) return 3;
    //    return 0;
    return [_cellTitleStringArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf = self;
    
    if (indexPath.section == 0) {
        CLMineAccountInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountInfoCellString forIndexPath:indexPath];
        if (!cell) {
            cell = [[CLMineAccountInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountInfoCellString];

        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.selectMineAccountCellBlock = ^(MineAccountSelectType accountCellSelectType) {
            if (accountCellSelectType == CL_MINE_ACCOUNT_MANAGEMENT) {
                [weakSelf performSegueWithIdentifier:@"mineToAccountManagementVC" sender:nil];
            }
        };
        return cell;
        
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        CLMineOrderAboutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:orderAboutTableViewCellString forIndexPath:indexPath];
        if (!cell) {
            cell = [[CLMineOrderAboutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderAboutTableViewCellString];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    if (indexPath.section == 2) {
        CLMineShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shareTableViewCellString forIndexPath:indexPath];
        if (!cell) {
            cell = [[CLMineShareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shareTableViewCellString];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherTableViewCellString forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherTableViewCellString];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont zntFont15];
    cell.textLabel.text = _cellTitleStringArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self performSegueWithIdentifier:@"mineVCToOrderVC" sender:nil];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"mineVCToFeedbackVC" sender:nil];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 200;
    if (indexPath.section == 1 && indexPath.row == 1) return 75;
    if (indexPath.section == 2) return 50;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2 || section == 3) return 12;
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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
