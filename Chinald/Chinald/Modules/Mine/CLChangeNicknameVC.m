//
//  CLChangeNicknameVC.m
//  Chinald
//
//  Created by WPFBob on 2018/3/31.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLChangeNicknameVC.h"
#import "CLMineNetworking.h"
#import "CLUserModel.h"
#import "CLMineRequest.h"

#import "UIView+ZNTHud.h"
@interface CLChangeNicknameVC ()
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;

@end

@implementation CLChangeNicknameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)saveNickname:(id)sender {
    [_nicknameTextField resignFirstResponder];
    NSString *nicknameString = _nicknameTextField.text;
    if (nicknameString == nil) {
        [self.view znt_showToast:@"请输入昵称"];
        return;
    }
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    
    nicknameString = [nicknameString stringByTrimmingCharactersInSet:set];
    if (nicknameString == 0) {
        [self.view znt_showToast:@"请输入昵称"];
        return;
    }
    CLUserModel *userModel = [CLUserModel sharedUserModel];
    [CLMineNetworking userEditInfo:@{@"name":nicknameString,@"token":userModel.token} complete:^(NSMutableDictionary *resultsObj) {
        [self.navigationController popViewControllerAnimated:YES];
    } theFailure:^(NSString *errorCode) {
        [self.view znt_showToast:errorCode];
    }];
//    [CLMineRequest userEditInfo:@{@"name":nicknameString,@"token":userModel.token} complete:^(NSMutableDictionary *resultsObj) {
//
//    } theFailure:^(NSString *errorCode) {
//
//    }];
    
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
