//
//  AppDelegate.m
//  Chinald
//
//  Created by shichuang on 2018/3/13.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "AppDelegate.h"
#import "CLGuideVC.h"

#import "CLMainPageVC.h"
#import "CLShoppingCartVC.h"
#import "CLMessageVC.h"
#import "CLMineVC.h"
#import "CLUserModel.h"
#import "ZNTTabBarController.h"

#import "ZNTRequest.h"
#import "ZNTReachabilityManager.h"

#import "ZNTLoginManager+ZNTEnter.h"
#import "ZNTLaunchManager.h"

#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <MAMapKit/MAMapKit.h>
#import "AppDelegate+ZNTPrivacy.h"
#import "AppDelegate+PushNotificcation.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)getAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //需要放在最前面的操作
    [self initAppConfigure:launchOptions];
    //初始化界面
    BOOL result = [self setupAppUI:launchOptions];
    //与界面无关的操作
    [self setupAppConfigure:launchOptions];
    [self initUserInfo];
    return result;
}

-(void)initUserInfo{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"userInfo"];    NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:path];
    CLUserModel *userModel = [CLUserModel sharedUserModel];
    CLUserModel *user = [[CLUserModel alloc]initWithDictionary:userDic error:nil];
    userModel = user;
}
- (void)initAppConfigure:(NSDictionary *)launchOptions
{
    [self registerRemoteNotification];
    
    //配置网络参数
    [ZNTRequest setupConfig];
    
    //首次进入添加网络状态监听
    [[ZNTReachabilityManager sharedManager] startMonitoring];
    
    //数据初始化,配置一些崩溃日志监控，配置统计分析埋点
    
}

- (BOOL)setupAppUI:(NSDictionary *)launchOptions
{
    [ZNTStyle setupStyple];
    
    // specific UI page for app
    [self _configureAppUI];
    
    BOOL result = YES;
    
    [LOGIN_MANAGER enterLoginWithGuideVC:![ZNTDataConfig sharedConfig].user];
    //闪屏，设置屏幕启动页
    [ZNTLaunchManager didFinishLaunching];
    
    return result;
}

- (void)setupAppConfigure:(NSDictionary *)launchOptions
{
    // app initialization path
    [self _setupAppPath];
}

- (void)_setupAppPath {
    [self _registerShareInformation];
    [self _checkUpdate];
    [self initLocationService];
}

- (void)initLocationService {
    //初始化高德地图apiKey
    [MAMapServices sharedServices].apiKey = [ZNTPublicConfig gaodeMapKey];
    [AMapLocationServices sharedServices].apiKey = [ZNTPublicConfig gaodeMapKey];
    [AMapSearchServices sharedServices].apiKey = [ZNTPublicConfig gaodeMapKey];
    //    [self getLocationPrivacy];
}

- (void)_checkUpdate {
    //    [KDVersionCheck checkUpdate:NO];
}

//注册新浪微博、微信、QQ等信息
- (void)_registerShareInformation {
    //    [WeiboSDK registerApp:KDWEIBO_SINA_APP_KEY];
    //    [WXApi registerApp:WECHAIT_APPID enableMTA:NO];
}

- (void)_configureAppUI {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.tintColor = ThemeTextColor;
    [self.window makeKeyAndVisible];
}


- (void)showGuideVC {
    CLGuideVC *guideVC = [[CLGuideVC alloc] init];
    self.window.rootViewController = guideVC;
}

- (void)setupMainViewControllers {
    //此处进入页面的时候注册推送服务
    
    NSArray *tabbarItemInfos = @[
                                 @{@"title":@"首页",@"selectedImage":@"nva_home_pre",@"image":@"nva_home"},
                                 @{@"title":@"购物车",@"selectedImage":@"nva_shoppingcar_pre",@"image":@"nva_shoppingcar"},
                                 @{@"title":@"消息",@"selectedImage":@"nva_news_pre",@"image":@"nva_news"},
                                 @{@"title":@"个人中心",@"selectedImage":@"nva_mine_pre",@"image":@"nva_mine"}
                                 ];
    
    NSMutableArray *tabbarNavs = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *tabbarVCs = @[[CLMainPageVC instanceFromXib],[CLShoppingCartVC instanceFromXib],[CLMessageVC instanceFromXib],[CLMineVC instanceFromXib]];
    
    for (int i = 0; i < tabbarVCs.count; i ++)
    {
        if (i > tabbarItemInfos.count - 1)
        {
            break;
        }
        
        NSDictionary *tabbarItemInfoDic = tabbarItemInfos[i];
        
        UIViewController *tabbarVC = tabbarVCs[i];
        tabbarVC.tabBarItem = [[UITabBarItem alloc] init];
        tabbarVC.tabBarItem.title = tabbarItemInfoDic[@"title"];
        [tabbarVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeColor} forState:UIControlStateSelected];
        [tabbarVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:ThemeTextColor} forState:UIControlStateNormal];
        [tabbarVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -5)];
        tabbarVC.tabBarItem.selectedImage = [[UIImage imageNamed:tabbarItemInfoDic[@"selectedImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabbarVC.tabBarItem.image = [[UIImage imageNamed:tabbarItemInfoDic[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        RTRootNavigationController *tabbarRootNav = [[RTRootNavigationController alloc] initWithRootViewController:tabbarVC];
        [tabbarNavs addObject:tabbarRootNav];
    }
    
    if (tabbarNavs.count == 0)
    {
        return;
    }
    
    self.tabBarController = [[ZNTTabBarController alloc] init];
    self.tabBarController.viewControllers = tabbarNavs;
    self.window.rootViewController = self.tabBarController;
    
    
    
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
