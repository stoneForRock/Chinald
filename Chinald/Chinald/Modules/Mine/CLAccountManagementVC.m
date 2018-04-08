//
//  CLAccountManagementVC.m
//  Chinald
//
//  Created by WPFBob on 2018/3/29.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLAccountManagementVC.h"
#import "EIPChoosePhotoViewController.h"

@interface CLAccountManagementVC ()
@property (strong, nonatomic) IBOutlet UITableView *managementTableView;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) UIImage *headIcon;
@property(nonatomic, copy)NSArray *tableViewData;  //!<
@end

@implementation CLAccountManagementVC
static NSString *managementTableCellString = @"CLAccountManagementVCCell";
INSTANCE_XIB_M(@"Mine", CLAccountManagementVC)
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableViewData = @[@{@"headTitle":@"个人资料",@"cellTitel":@[@"会员号",@"推荐人",@"关注时间",@"手机号码"]},@{@"headTitle":@"个人资料",@"cellTitel":@[@"更换头像",@"更换昵称",@"公开手机号",@"修改绑定手机",@"收货地址管理"]}];
    [_managementTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:managementTableCellString];
    _logoutButton.layer.borderColor = [UIColor colorWithHexRGB:@"0x999999"].CGColor;
    self.navigationItem.title = @"账号管理";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _tableViewData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableViewData[section][@"cellTitel"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:managementTableCellString forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:managementTableCellString];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 39, 24)];
            button.titleLabel.font = [UIFont zntFont12];
            button.layer.cornerRadius = 2;
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor clDividingLineColor].CGColor;
            [button setTitle:@"显示" forState:0];
            [button setTitleColor:Color5 forState:0];
            cell.accessoryView = button;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 0) {
            UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 7, 50, 50)];
            headImageView.image = _headIcon;
            headImageView.layer.cornerRadius = 25;
            headImageView.layer.masksToBounds = YES;
            cell.accessoryView = headImageView;
        }
        if (indexPath.row == 2) {
            UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectMake(0, 7, 32, 30)];
            cell.accessoryView = switchView;
        }
    }

    cell.textLabel.text = _tableViewData[indexPath.section][@"cellTitel"][indexPath.row];
    cell.textLabel.font = [UIFont zntFont13];
    cell.textLabel.textColor = Color5;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        //选择头像
        if (indexPath.row == 0) {
            __weak __typeof(self) weakSelf = self;

            EIPChoosePhotoViewController *choosePhotoVC = [EIPChoosePhotoViewController new];
            [choosePhotoVC seletTheImageFormAlert:self AlertTitle:@"选择头像照片"];
            choosePhotoVC.isCropperImage = YES;
            choosePhotoVC.entryInvoiceDataBlock = ^(UIImage *image){
                
                
                [self dismissViewControllerAnimated:YES completion:^{
                    weakSelf.headIcon = image;
                    [weakSelf.managementTableView reloadData];
                }];
            };
            
        }
        //修改用户名
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"accountManagementVCToChamgeNicknameVC" sender:nil];
        }
        //修改绑定的手机号
        if (indexPath.row == 3) {
            [self performSegueWithIdentifier:@"acountManageVCToChangePhoneVC" sender:nil];
        }
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 43)];
    view.backgroundColor = CLVCBackgroundColor;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, ScreenFullWidth - 24, 43)];
    titleLabel.textColor = Color5;
    titleLabel.font = [UIFont zntFont14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = _tableViewData[section][@"headTitle"];
    [view addSubview:titleLabel];
    return view;
    
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section == 1) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 43)];
//        view.backgroundColor = CLVCBackgroundColor;
//        UIButton *logOutButton = [[UIButton alloc]initWithFrame:CGRectMake(38, 34, ScreenFullWidth - 76, 44)];
//        [logOutButton setTitle:@"退出登录" forState:0];
//        [logOutButton setTitleColor:Color6 forState:0];
//        logOutButton.titleLabel.font = [UIFont zntFont16];
//        logOutButton.backgroundColor = [UIColor whiteColor];
//        logOutButton.layer.cornerRadius = 22;
//        logOutButton.layer.borderWidth = 1;
//        logOutButton.layer.borderColor = [UIColor colorWithHexRGB:@"0x999999"].CGColor;
//        [view addSubview:logOutButton];
//        return view;
//    }
//    return nil;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) return 64;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 43;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 1) {
//        return 111;
//    }
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
