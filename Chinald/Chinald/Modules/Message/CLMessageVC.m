//
//  CLMessageVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/16.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageVC.h"
#import "CLMessageModel.h"
#import "CLMessageListTableViewCell.h"
#import "CLMessageNetworking.h"
#import "UIView+ZNTHud.h"
@interface CLMessageVC ()
@property(nonatomic, strong)NSMutableArray *messageArray;  //!<
@property (strong, nonatomic) IBOutlet UITableView *messageTableView;

@end

@implementation CLMessageVC
static NSString  *messageListCell = @"messageListCell";

INSTANCE_XIB_M(@"Message", CLMessageVC)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息";
    
    _messageArray = [[NSMutableArray alloc]initWithCapacity:0];
}
-(void)requestMessageList{
    [self.view znt_showHUD:nil];
    [CLMessageNetworking messageIndex:nil complete:^(NSMutableArray *resultsObj) {
        [self.view znt_hideHUD];
        [_messageArray removeAllObjects];
        [_messageArray addObjectsFromArray:resultsObj];
        if (_messageTableView) {
            [_messageTableView reloadData];
        }
    } theFailure:^(NSString *errorCode) {
        [self.view znt_hideHUD];
        [self.view znt_showToast:errorCode];
    }];
}
#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return _messageArray.count;
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        CLMessageListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[CLMessageListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageListCell];
            
        }
    cell.messageModel = _messageArray[indexPath.row];
    
        return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
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
