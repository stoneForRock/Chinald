//
//  CLMessageDetailVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/17.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMessageDetailVC.h"
#import "CLMessageDetailModel.h"
#import "CLMessageDetailTableViewCell.h"

@interface CLMessageDetailVC ()
@property(nonatomic, strong)NSMutableArray *messageArray;  //!<
@end

@implementation CLMessageDetailVC
static NSString  *messageDetailCell = @"messageDetailCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    CLMessageDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CLMessageDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageDetailCell];
        
    }
    //    cell.messageModel = _messageArray[indexPath.row];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenFullWidth, 37)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 0, ScreenFullWidth - 26, 37)];
    titleLabel.textColor = [UIColor colorWithHexRGB:@"0xBDBDBD"];
    titleLabel.font = [UIFont zntFont14];
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
