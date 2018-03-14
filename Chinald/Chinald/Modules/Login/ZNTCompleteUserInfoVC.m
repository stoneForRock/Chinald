//
//  ZNTCompleteUserInfoVC.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/7.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTCompleteUserInfoVC.h"
#import "KDInputView.h"
#import "ZNTThemeButton.h"
#import "ZNTLoginManager.h"
#import "ZNTUploadImageManager.h"
#import "UIAlertController+ZNTAdd.h"
#import "ShowBigImage.h"

static NSString *const idNameInputPlaceholder = @"请输入营运人名称（必须和身份证上相同）";
static NSString *const nameInputPlaceholder = @"请输入公司名称（必须和营业执照上相同）";
static NSString *const idInputPlaceholder = @"请填写营运人身份证号码";
static NSString *const businessPlaceholder = @"请输入公司统一社会信用代码";
static NSString *const registBtnTitle = @"注册";

@interface ZNTCompleteUserInfoVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDelegate,ShowBigImageDelegate>

@property (nonatomic, strong) KDInputView *customNameInputView;
@property (nonatomic, strong) KDInputView *bussinessIdInpuView;
@property (nonatomic, strong) ZNTThemeButton *registBtn;

@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
@property (weak, nonatomic) IBOutlet UIButton *personalBtn;

@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *businessImgView;
@property (weak, nonatomic) IBOutlet UIView *businessTipsView;
@property (weak, nonatomic) IBOutlet UILabel *imageTipsLabel;

@property (nonatomic, strong) ShowBigImage *bigImageBrowser;

@end

@implementation ZNTCompleteUserInfoVC

INSTANCE_XIB_M(@"Login", ZNTCompleteUserInfoVC)

- (ShowBigImage *)bigImageBrowser {
    if (!_bigImageBrowser) {
        _bigImageBrowser = [[ShowBigImage alloc] init];
        _bigImageBrowser.bigImagedelegate = self;
        [_bigImageBrowser setShowStyle:ShowBigImageUploadStyle];
    }
    
    return _bigImageBrowser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataInfo];
    
    [self initUI];
    
    UITapGestureRecognizer *uploadGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadAction)];
    [self.businessImgView addGestureRecognizer:uploadGesture];
    
    [self refreInputDataWithType:@"0"];
}

- (void)initUI {
    
    self.title = @"完善资料";
    
    [self setupViews];
    [self make_mas];
}

- (void)setupViews {
    [self.view addSubview:self.customNameInputView];
    [self.view addSubview:self.bussinessIdInpuView];
    [self.view addSubview:self.registBtn];
}

- (void)make_mas {
    
    [self.customNameInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.companyBtn.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];
    
    // bussinessIdInpuView
    [self.bussinessIdInpuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.customNameInputView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(45);
    }];

    
    [self.businessImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.bussinessIdInpuView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(((ScreenFullWidth - 2*[NSNumber zntDistance3])/658) * 345);
    }];
    
    [self.businessTipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.businessImgView.mas_centerY);
        make.centerX.mas_equalTo(self.businessImgView.mas_centerX);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(25);
    }];
    
    // registBtn
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset([NSNumber zntDistance3]);
        make.right.equalTo(self.view.mas_right).with.offset(-[NSNumber zntDistance3]);
        make.top.equalTo(self.businessImgView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(44);
    }];
}

- (void)initDataInfo {
    self.user.ownerType = @"0";
    self.companyBtn.selected = YES;
}

- (void)uploadAction {
    //如果已经有图片的话，就展示出图片
    if (self.businessImgView.image && self.user.cardPic.length > 0) {
        [self.bigImageBrowser showWithImage:self.businessImgView.image];
    } else {
        //没有图片直接是上传
        [self showUploadActionSheet];
    }
    
}

//点击重新上传按钮
- (void)reUploadImageAction:(ShowBigImage *)bigImage {
    [self showUploadActionSheet];
}

- (void)showUploadActionSheet {
    BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.delegate = self;
    
    NSUInteger cancelIndex = 1;
    [actionSheet addButtonWithTitle:@"相册"];
    
    if (hasCamera) {
        cancelIndex++;
        [actionSheet addButtonWithTitle:@"拍照"];
    }
    
    [actionSheet addButtonWithTitle:@"取消"];
    actionSheet.cancelButtonIndex = cancelIndex;
    
    [actionSheet showInView:self.view];
}

- (IBAction)selectedCompany:(UIButton *)sender {
    self.personalBtn.selected = NO;
    sender.selected = YES;
    self.user.ownerType = @"0";
    [self refreInputDataWithType:self.user.ownerType];
}

- (IBAction)selectedPersonal:(UIButton *)sender {
    self.companyBtn.selected = NO;
    sender.selected = YES;
    self.user.ownerType = @"1";
    [self refreInputDataWithType:self.user.ownerType];
}

- (void)refreInputDataWithType:(NSString *)ownerType {
    self.customNameInputView.textFieldMain.text = @"";
    self.bussinessIdInpuView.textFieldMain.text = @"";
    self.user.cardPic = @"";
    if ([ownerType isEqualToString:@"0"]) {
        self.customNameInputView.textFieldMain.placeholder = nameInputPlaceholder;
        self.bussinessIdInpuView.textFieldMain.placeholder = businessPlaceholder;
        self.imageTipsLabel.text = @"点击上传营业执照图片";
        
    } else if ([ownerType isEqualToString:@"1"]) {
        self.customNameInputView.textFieldMain.placeholder = idNameInputPlaceholder;
        self.bussinessIdInpuView.textFieldMain.placeholder = idInputPlaceholder;
        self.imageTipsLabel.text = @"点击上传身份证照片";
    }
}

- (void)registAction:(UIButton *)sender {
    [self.view znt_showHUD:@"请稍候..."];
    ZNTWeak(self)
    [ZNTLoginRequest registCustomWithOwnerType:self.user.ownerType phone:self.user.phone password:self.user.password name:self.customNameInputView.textFieldMain.text card:self.bussinessIdInpuView.textFieldMain.text cardPic:self.user.cardPic onSuccess:^(id  _Nullable responseObject) {
        ZNTStrong(self)
        [self.view znt_hideHUD];
        
        [ZNTDataConfig sharedConfig].user = self.user;
        [[ZNTDataConfig sharedConfig] saveConfig];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"注册成功！立即登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *commitAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        commitAction.textColor = ThemeColor;
        [alert addAction:commitAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } onFailure:^(NSError * _Nullable error) {
        ZNTStrong(self)
        [self.view znt_hideHUD];
        [self.view znt_showToast:error.domain];
    }];
}

- (void)textChanged:(UITextField *)textField {
    [self refreshRegistBtnStatus];
}

- (void)refreshRegistBtnStatus {
    BOOL hasNameText = (self.customNameInputView.textFieldMain.text.length > 0 && self.customNameInputView.textFieldMain.text.length > 0);
    BOOL hasIdText = (self.bussinessIdInpuView.textFieldMain.text.length > 0 && self.bussinessIdInpuView.textFieldMain.text.length > 0);
    if (hasNameText && hasIdText && self.user.cardPic) {
        [self.registBtn enableTouch];
    }
    else {
        [self.registBtn disableTouch];
    }
}

- (KDInputView *)customNameInputView {
    if (!_customNameInputView) {
        _customNameInputView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        _customNameInputView.imageViewLeft.image = [UIImage imageNamed:@"tf_name"];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:nameInputPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_customNameInputView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_customNameInputView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return  _customNameInputView;
}

- (KDInputView *)bussinessIdInpuView {
    if (!_bussinessIdInpuView) {
        _bussinessIdInpuView = [[KDInputView alloc] initZLZBisinessInputWithElement:KDInputViewElementImageViewLeft|KDInputViewElementZLZInputView shouldFormatPhoneNumber:NO];
        _bussinessIdInpuView.imageViewLeft.image = [UIImage imageNamed:@"tf_idcode"];
        NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:businessPlaceholder];
        [attributePlaceholder dz_setTextColor:ThemePlaceholderColor];
        [_bussinessIdInpuView.textFieldMain setAttributedPlaceholder:attributePlaceholder];
        [_bussinessIdInpuView.textFieldMain addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _bussinessIdInpuView;
}

- (ZNTThemeButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [[ZNTThemeButton alloc] init];
        [_registBtn disableTouch];
        [_registBtn setTitle:registBtnTitle forState:UIControlStateNormal];
        [_registBtn addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.cancelButtonIndex == buttonIndex) return;
    
    if (0x00 == buttonIndex) {
        [self presentImagePickerController:NO];
    }
    else if (0x01 == buttonIndex) {
        [self presentImagePickerController:YES];
    }
    
}
- (void)presentImagePickerController:(BOOL)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    if (takePhoto) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController presentViewController:picker animated:YES completion:nil];
    });
}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (image != nil) {
        
        NSString *remindString = @"正在上传，请稍候...";
        if ([self.user.ownerType isEqualToString:@"0"]) {
            remindString = @"正在上传营业执照，请稍候...";
        } else if ([self.user.ownerType isEqualToString:@"1"]) {
            remindString = @"正在上传营运证，请稍候...";
        }
        [self.view znt_showHUD:remindString];
        ZNTWeak(self)
        [[ZNTUploadImageManager shared] uploadImageWithQiniuSpace:qiNiuAccountSpace image:image uploadImageComplete:^(BOOL success, NSString *url, NSString *errorMsg) {
            ZNTStrong(self)
            [self.view znt_hideHUD];
            if (success) {
                [self.view znt_showToast:@"上传成功"];
                [self.businessImgView sd_setImageWithURL:[NSURL URLWithString:url]];
                self.user.cardPic = url;
                [self refreshRegistBtnStatus];
            } else {
                [self.view znt_showToast:errorMsg];
            }
        }];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
