//
//  CLSetViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/24.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLSetViewController.h"
#import <UShareUI/UShareUI.h>

@interface CLSetViewController ()
@property (strong, nonatomic) IBOutlet UITableView *setTableView;

@end

@implementation CLSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
}
#pragma mark-------tableview代理方法  UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *setCellString = @"setCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:setCellString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:setCellString];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @[@"APP版本",@"分享APP下载地址",@"清除缓存"][indexPath.row];
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        NSDictionary *versionDic = [[NSBundle mainBundle]infoDictionary];
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"当前版本%@",[versionDic objectForKey:@"CFBundleShortVersionString"]];
    }
    if (indexPath.row == 2) {
        // 获取Caches目录路径
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        float fileSize = 0;
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSFileManager* manager = [NSFileManager defaultManager];
        
        for (NSString *p in files) {
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            NSLog(@"path======%@",path);
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                fileSize = fileSize +  [[manager attributesOfItemAtPath:path error:nil] fileSize];
            }
        }
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fKB",fileSize/1024.0];
    }
    cell.textLabel.font = [UIFont zntFont13];
    cell.textLabel.textColor = Color5;
    cell.detailTextLabel.font = [UIFont zntFont13];
    cell.detailTextLabel.textColor = Color5;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf = self;
    
    if (indexPath.row == 1) {
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [weakSelf shareTextToPlatformType:platformType];
            
        }];
    }
    if (indexPath.row == 2) {
        [self clearCache];
    }
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
//确定清除缓存
-(void)clearCache
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           
                           NSLog(@"缓存文件的地址是==%@",path);
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
    
}
-(void)clearCacheSuccess{
    [_setTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
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
