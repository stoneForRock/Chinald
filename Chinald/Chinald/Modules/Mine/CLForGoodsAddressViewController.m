//
//  CLForGoodsAddressViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/10.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLForGoodsAddressViewController.h"
#import "CLAddressTableViewCell.h"
#import "CLEditAddressViewController.h"
#import "CLMineNetworking.h"
#import "UIView+ZNTHud.h"
#define KWeakSelf(type)  __weak typeof(type) weak##type = type

@interface CLForGoodsAddressViewController ()
@property (strong, nonatomic) IBOutlet UITableView *forGoodsAddressTableView;
@property(nonatomic, strong) NSMutableArray *addressArray; //!<
@property(nonatomic, strong) CLTheGoodsAddressModel *selectAddressModel;//!<
@end

@implementation CLForGoodsAddressViewController
static NSString *addAddressCell = @"addAddressCell";
static NSString *forGoodsAddressCell = @"forGoodsAddressCell";
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestAddressList];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"收货地址";
    _addressArray = [[NSMutableArray alloc]initWithCapacity:0];
    [_forGoodsAddressTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:addAddressCell];
}
-(void)requestAddressList{
    KWeakSelf(self);
    [CLMineNetworking addressIndexComplete:^(NSMutableArray *resultsObj) {
        [weakself.addressArray removeAllObjects];
        [weakself.addressArray addObjectsFromArray:resultsObj];
        [weakself.forGoodsAddressTableView reloadData];
    } theFailure:^(NSString *errorCode) {
        [weakself.view znt_showToast:errorCode];
    }];
}
#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _addressArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KWeakSelf(self);
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addAddressCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:addAddressCell];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"新增收货地址";
        cell.textLabel.font = [UIFont zntFont14];
        cell.textLabel.textColor = Color5;
        return cell;
    }
    CLAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:forGoodsAddressCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[CLAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:forGoodsAddressCell];
    }
    
    cell.goodsAddressModel = _addressArray[indexPath.section - 1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectForGoodsAddresCellBlock = ^(ForGoodsAddressOperationType forGoodsAddressOperationType, CLTheGoodsAddressModel *addressModel) {
        _selectAddressModel = addressModel;
        if (forGoodsAddressOperationType == CL_ADDRESS_EDIT) {
                [self performSegueWithIdentifier:@"addressListVCToEditAddressVC" sender:nil];
        }
        if (forGoodsAddressOperationType == CL_ADDRESS_DELETE) {
            [weakself deleteAddress];
        }
        if (forGoodsAddressOperationType == CL_ADDRESS_DEFAULT) {
            [weakself defaultAddress];
        }
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        _selectAddressModel = nil;
    }else{
        _selectAddressModel = _addressArray[indexPath.section - 1];
    }
    [self performSegueWithIdentifier:@"addressListVCToEditAddressVC" sender:nil];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 49;
    return 116;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 3;
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}

//删除收货地址
-(void)deleteAddress{
    KWeakSelf(self);
    [CLMineNetworking addressDelete:_selectAddressModel complete:^(NSMutableDictionary *resultsObj) {
        [weakself requestAddressList];
    } theFailure:^(NSString *errorCode) {
        [weakself.view znt_showToast:errorCode];
    }];
}
//设置为默认地址
-(void)defaultAddress{
    KWeakSelf(self);
    [CLMineNetworking addressDefault:_selectAddressModel complete:^(NSMutableDictionary *resultsObj) {
        [weakself requestAddressList];
    } theFailure:^(NSString *errorCode) {
        [weakself.view znt_showToast:errorCode];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addressListVCToEditAddressVC"]) {
        CLEditAddressViewController *editAddressVC = (CLEditAddressViewController *)segue.destinationViewController;
        editAddressVC.addressModel = _selectAddressModel;
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
