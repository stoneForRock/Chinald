//
//  CLMineVC.m
//  Chinald
//
//  Created by shichuang on 2018/3/14.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineVC.h"
#import "ZNTLoginVC.h"
#import "CLMyOrderVC.h"
#import "CLUserModel.h"
#import "CLOrderOperationItem.h"

#import "CLMineOrderAboutTableViewCell.h"
#import "CLMineShareTableViewCell.h"
#import "CLMineAccountInfoTableViewCell.h"
#import "CLAboutUsVC.h"
#import "CLMyQrCodeVC.h"
#import <UShareUI/UShareUI.h>
@interface CLMineVC ()
@property (strong, nonatomic) IBOutlet UITableView *mineTableView;
@property(nonatomic, strong) NSArray *cellTitleStringArray; //!<
@property(nonatomic, assign) NSInteger selectOrderType;  //!<
@end

@implementation CLMineVC
static NSString *accountInfoCellString = @"CLMineAccountInfoTableViewCell";
static NSString *orderAboutTableViewCellString = @"CLMineOrderAboutTableViewCell";
static NSString *shareTableViewCellString = @"CLMineShareTableViewCell";

static NSString *otherTableViewCellString = @"CLMineOtherTableViewCell";

INSTANCE_XIB_M(@"Mine", CLMineVC)
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CLUserModel *userModel = [CLUserModel sharedUserModel];
    if (!userModel.token) {
        ZNTLoginVC *loginVC = [ZNTLoginVC instanceFromXib];
        [self presentViewController:loginVC animated:YES completion:^{
        }];
    }else{
        [_mineTableView reloadData];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    if (@available(iOS 11, *)){
        _mineTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //    self.title = @"个人中心";
    _cellTitleStringArray = @[@[@""],@[@"我的订单",@""],@[@""],@[@"关于我们",@"我要吐槽",@"APP设置"]];
    [_mineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:otherTableViewCellString];
    [_mineTableView registerClass:[CLMineAccountInfoTableViewCell class] forCellReuseIdentifier:accountInfoCellString];
    _selectOrderType = 0;
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
        cell.selectOrderTypeBlock = ^(NSInteger orderType) {
            weakSelf.selectOrderType = orderType;
            [weakSelf performSegueWithIdentifier:@"mineVCToOrderVC" sender:nil];
            CLMyQrCodeVC *qrCodeVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil]instantiateViewControllerWithIdentifier:@"CLMyQrCodeVC"];
            [weakSelf.navigationController pushViewController:qrCodeVC animated:YES];
        };
        return cell;
    }
    if (indexPath.section == 2) {
        CLMineShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shareTableViewCellString forIndexPath:indexPath];
        if (!cell) {
            cell = [[CLMineShareTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shareTableViewCellString];
        }
        cell.selectShareOrMyQrcodeBlock = ^(ShareQrcodeItemType orderType) {
            if (orderType == CL_MINE_QRCODE) {
                
                [weakSelf performSegueWithIdentifier:@"mineVCToMyQrcodeVC" sender:nil];
            }
            if (orderType == CL_MINE_SHARE) {
                //                [weakSelf performSegueWithIdentifier:@"mineVCToOrderVC" sender:nil];
                //                [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                //                    [weakSelf shareTextToPlatformType:platformType];
                //                }];
                
                [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
                [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                    // 根据获取的platformType确定所选平台进行下一步操作
                    [weakSelf shareTextToPlatformType:platformType];
                    
                }];
            }
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherTableViewCellString forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:otherTableViewCellString];
        
    }
    [[cell viewWithTag:1000] removeFromSuperview];
    UIView *hLineView = [[UIView alloc]init];
    hLineView.tag = 1000;
    hLineView.backgroundColor = CLLineColor;
    if (indexPath.section == 1 && indexPath.row == 0) {
        hLineView.frame = CGRectMake(17, cell.bounds.size.height - 0.5, ScreenFullWidth - 30, 0.5);
        [cell addSubview:hLineView];
        
    }
    if (indexPath.section == 3 && indexPath.row != 2) {
        hLineView.frame = CGRectMake(0, cell.bounds.size.height - 0.5, ScreenFullWidth, 0.5);
        [cell addSubview:hLineView];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont zntFont15];
    cell.textLabel.text = _cellTitleStringArray[indexPath.section][indexPath.row];
    return cell;
}

//分享文本消息
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            _selectOrderType = 0;
            [self performSegueWithIdentifier:@"mineVCToOrderVC" sender:nil];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            CLAboutUsVC *aboutVC = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"CLAboutUsVC"];
            [self.navigationController pushViewController:aboutVC animated:YES];
            
        }
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"mineVCToFeedbackVC" sender:nil];
        }
        if (indexPath.row == 2) {
            [self performSegueWithIdentifier:@"mineVCToSetVC" sender:nil];
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
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"mineVCToOrderVC"]) {
        CLMyOrderVC *orderVC = (CLMyOrderVC *)segue.destinationViewController;
        orderVC.orderType = _selectOrderType;
    }
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
