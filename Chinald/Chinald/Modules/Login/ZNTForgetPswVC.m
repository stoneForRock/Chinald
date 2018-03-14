//
//  ZNTForgetPswVC.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/7.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTForgetPswVC.h"
#import "KDInputView.h"
#import "ZNTThemeButton.h"
#import "ZNTLoginRequest.h"
#import "ZNTLoginManager.h"
#import "UIAlertController+ZNTAdd.h"

static NSString *const passwordInputPlaceholder = @"请输入新密码";
static NSString *const passwordConfimInputPlaceholder = @"请再次输入新密码";
static NSString *const nextStepBtnTitle = @"确定";

@interface ZNTForgetPswVC ()

@property (nonatomic, strong) KDInputView *passwordInpuView;
@property (nonatomic, strong) KDInputView *passwordConfimInpuView;

@property (nonatomic, strong) ZNTThemeButton *nextStepBtn;


@end

@implementation ZNTForgetPswVC

INSTANCE_XIB_M(@"Login", ZNTForgetPswVC)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
}

- (void)initUI {
    self.title = @"输入新密码";
    self.view.backgroundColor = ZNTVCBacgroundColor;

    [self setupViews];
    [self make_mas];
}

- (void)setupViews {
    [self.view addSubview:self.passwordInpuView];
    [self.view addSubview:self.passwordConfimInpuView];
    [self.view addSubview:self.nextStepBtn];
}

- (void)make_mas {
   
    // inputViewPassword
    [self.passwordInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(18);
        make.height.mas_equalTo(45);
    }];
    
    // passwordConfimInpuView
    [self.passwordConfimInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.top.equalTo(self.passwordInpuView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(45);
    }];
    
    
    // nextStepBtn
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.passwordConfimInpuView.mas_bottom).with.offset(74);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)initDataInfo {
    if (!self.user) {
        self.user = [[ZNTUser alloc] init];
    }
}

//下一步
- (void)nextStepAction:(UIButton *)sender {
    if (![self.passwordInpuView.textFieldMain.text isEqualToString:self.passwordConfimInpuView.textFieldMain.text]) {
        [self.view znt_showToast:@"输入密码不一致，请重新输入"];
        
        return;
    }
    
    [self.view znt_showHUD:@"请稍候..."];
    ZNTWeak(self)
    [ZNTLoginRequest updatePasswordWithPhone:self.user.phone type:kUserType psw:self.passwordInpuView.textFieldMain.text onSuccess:^(id  _Nullable responseObject) {
        ZNTStrong(self)
        [self.view znt_hideHUD];
        if (self.isFromSettingVC) {
            [self.view znt_showToast:@"修改密码成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"密码修改成功！请重新登录" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            commitAction.textColor = ThemeColor;
            [alert addAction:commitAction];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } onFailure:^(NSError * _Nullable error) {
        ZNTStrong(self)
        [self.view znt_hideHUD];
        [self.view znt_showToast:error.domain];
    }];
}

- (void)textChanged:(UITextField *)textField {
    BOOL hasPswText = (self.passwordInpuView.textFieldMain.text.length > 0 && self.passwordInpuView.textFieldMain.text.length > 0);
    BOOL hasPswConText = (self.passwordConfimInpuView.textFieldMain.text.length > 0 && self.passwordConfimInpuView.textFieldMain.text.length > 0);
    
    if (hasPswConText && hasPswText) {
        [self.nextStepBtn enableTouch];
    }
    else {
        [self.nextStepBtn disableTouch];
    }
}

- (KDInputView *)passwordInpuView {
    if (!_passwordInpuView) {
        _passwordInpuView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:passwordInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_passwordInpuView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_passwordInpuView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _passwordInpuView.textFieldMain.secureTextEntry = YES;
        [_passwordInpuView changeToZLZStyle];
        _passwordInpuView.backgroundColor = [UIColor whiteColor];
    }
    
    return _passwordInpuView;
}

- (KDInputView *)passwordConfimInpuView {
    if (!_passwordConfimInpuView) {
        _passwordConfimInpuView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:passwordConfimInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_passwordConfimInpuView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_passwordConfimInpuView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        _passwordConfimInpuView.textFieldMain.secureTextEntry = YES;
        [_passwordConfimInpuView changeToZLZStyle];
        _passwordConfimInpuView.backgroundColor = [UIColor whiteColor];
    }
    
    return _passwordConfimInpuView;
}

- (ZNTThemeButton *)nextStepBtn {
    if (!_nextStepBtn) {
        _nextStepBtn = [[ZNTThemeButton alloc] init];
        [_nextStepBtn disableTouch];
        [_nextStepBtn setTitle:nextStepBtnTitle forState:UIControlStateNormal];
        [_nextStepBtn addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStepBtn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
