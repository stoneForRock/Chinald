//
//  CLMessageDetailVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageDetailVC.h"
#import "CLMessageModel.h"
#import "CLUserModel.h"
#import "CLMessageNetworking.h"
#import "CLMessageDetailTableViewCell.h"
#import "UIView+ZNTHud.h"
#import "NSString+DZCategory.h"
@interface CLMessageDetailVC ()
@property(nonatomic, strong)NSMutableArray *messageArray;  //!<
@property(nonatomic, strong)CLMessageDetailRequsetModel *detailRequestModel;  //!<
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CLMessageDetailVC
static NSString  *messageDetailCell = @"messageDetailCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _messageArray = [[NSMutableArray alloc]initWithCapacity:0];
    _detailRequestModel = [[CLMessageDetailRequsetModel alloc]init];
    [self initRequestModel];
}
-(void)initRequestModel{
    _detailRequestModel.page = 1;
    _detailRequestModel.pagesize = 100;
    _detailRequestModel.type = _messageModel.type;
    _detailRequestModel.token = [CLUserModel sharedUserModel].token;

}
-(void)requestMessageList{
    [CLMessageNetworking messageNotice:_detailRequestModel complete:^(NSMutableArray *resultsObj) {
        if (_detailRequestModel.page == 0) {
            [_messageArray removeAllObjects];
        }
        [_messageArray addObjectsFromArray:resultsObj];
        if (_tableView) {
            [_tableView reloadData];
        }
    } theFailure:^(NSString *errorCode) {
        [self.view znt_showToast:errorCode];
    }];
}
#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _messageArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CLMessageDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CLMessageDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageDetailCell];
        
    }
    cell.messageDetailModel = _messageArray[indexPath.section];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLMessageDetailModel *detailModel = _messageArray[indexPath.section];
    CGSize size = [detailModel.content kd_sizeForMaxWidth:ScreenFullWidth - 54 font:Font14];
    return size.height + 30;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CLMessageDetailModel *detailModel = _messageArray[section];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 37)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, ScreenFullWidth - 26, 37)];
    titleLabel.textColor = [UIColor colorWithHexRGB:@"0xBDBDBD"];
    titleLabel.font = Font14;
    titleLabel.text = detailModel.addTime;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
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
