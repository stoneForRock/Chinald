//
//  CLFeedbackVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/1.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLFeedbackVC.h"
#import "PhotoAlbumVC.h"
#import <AVFoundation/AVFoundation.h>
#import "UIImage+fixOrientation.h"
#import "UIImage+UploadImage.h"
#import "CLMineNetworking.h"
#import "CLFeedbackRequest.h"

#define MAXCOUNT 5
@interface CLFeedbackVC ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSMutableArray *_upLoadIamgeMutableArray;//上传用户建议图片
    IBOutlet UIButton *_selectImageButton;
    IBOutlet UIView *_backView;
    IBOutlet NSLayoutConstraint *_selectImageButtonLeft;
    IBOutlet UIButton *_subButton;

}
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UILabel *numberOfStringLabel;
@property (strong, nonatomic) IBOutlet UIView *inputBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@end

@implementation CLFeedbackVC
static int kImageViewWidth = 50;
static int kLineNumberImage = 5;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我要吐槽";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewTextChange)name:UITextViewTextDidChangeNotification object:nil];
    _inputBackgroundView.layer.borderColor = [UIColor clDividingLineColor].CGColor;
    
    _upLoadIamgeMutableArray = [[NSMutableArray alloc]initWithCapacity:0];
}
#pragma mark =========== 监听输入框内容和键盘的显示、隐藏 ===========
- (void)textViewTextChange
{
    if (_feedbackTextView.text.length > 0) {
        _feedbackTextView.alpha = 1;
        if (_feedbackTextView.text.length >= 500 ) {
            _feedbackTextView.text = [_feedbackTextView.text substringToIndex:500];
            _numberOfStringLabel.text = @"500/500";

        }else{
            _numberOfStringLabel.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)_feedbackTextView.text.length];
        }
    }else{
        _feedbackTextView.alpha = 0.7;
        _numberOfStringLabel.text = @"0/500";
    }
    
}
- (IBAction)selectImageButtonClick:(id)sender {
    __weak __typeof(self) wealSelf = self;
    if (_upLoadIamgeMutableArray.count >= MAXCOUNT) {
        [self.view znt_showToast:@"最多选择5张图片"];
    }
    UIButton *button = (UIButton *)sender;

    UIAlertController *selectAlertController = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *popPresenter = [selectAlertController popoverPresentationController];
        popPresenter.sourceView = button;
        popPresenter.sourceRect = button.bounds;
        [self presentViewController:selectAlertController animated:YES completion:nil];
        
    }else{
        [self presentViewController:selectAlertController animated:YES completion:nil];
    }
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //从相册选择图片
        [PhotoAlbumVC showFromViewController:self maxCount:MAXCOUNT - (int)_upLoadIamgeMutableArray.count completion:^(NSArray * _Nonnull list) {
            [_upLoadIamgeMutableArray addObjectsFromArray:list];
            [wealSelf refreshImage];

        }];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //从相机拍照选择
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {

            NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
            NSString *displayName = [infoDic objectForKey:@"CFBundleDisplayName"];
            
            NSString *description = [NSString stringWithFormat:@"相机访问受限，请在设置\\隐私\\相机中打开%@相机访问权限",displayName];
            
            UIAlertController *cameraPermissionsAlertController = [UIAlertController alertControllerWithTitle:description message:nil preferredStyle:UIAlertControllerStyleAlert];
            [wealSelf presentViewController:cameraPermissionsAlertController animated:YES completion:nil];
            UIAlertAction * enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            [cameraPermissionsAlertController addAction:enterAction];
        }else{
            [wealSelf pickImageFromCamera];
        }
    }];
    UIAlertAction *escAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [cameraAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
    [albumAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
    [escAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];

    [selectAlertController addAction:albumAction];
    [selectAlertController addAction:cameraAction];
    [selectAlertController addAction:escAction];
}


#pragma mark 从摄像头获取活动图片
- (void)pickImageFromCamera
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&[mediatypes count]>0){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = YES;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        //        [self.navigationController pushViewController:imagePicker animated:YES];
    }else{
        //设备不支持相机功能
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    image = [UIImage clCompressImageQuality:image toByte:250000];
    
    if (_upLoadIamgeMutableArray.count < MAXCOUNT) {
        [_upLoadIamgeMutableArray addObject:image];
    }
    [self refreshImage];
}

-(void)refreshImage{
    float space = (ScreenFullWidth - kLineNumberImage * kImageViewWidth ) / (float)(kLineNumberImage + 1);
    for (int i = 0; i < 5; i++) {
        UIView *view = [_backView viewWithTag:1000 + i];
        [view removeFromSuperview];
        UIView *view1 = [_backView viewWithTag:2000 + i];
        [view1 removeFromSuperview];
    }
    
    for (int i = 0; i < _upLoadIamgeMutableArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(space + (space + kImageViewWidth) * i, 270, kImageViewWidth, kImageViewWidth)];
        imageView.tag = 1000 + i;
        imageView.image = _upLoadIamgeMutableArray[i];
        [_backView addSubview:imageView];
        
        UIButton *btu = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.origin.x + kImageViewWidth - 5 , 265, 10, 10)];
        [btu setBackgroundImage: [UIImage imageNamed:@"icon_image_delete"] forState:0];
        btu.tag = 2000 + i;
        [btu addTarget:self action:@selector(deletButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:btu];
    }
    
    if (_upLoadIamgeMutableArray.count < MAXCOUNT) {
        _selectImageButton.hidden = NO;
        if (_upLoadIamgeMutableArray.count == 0) {
            _selectImageButtonLeft.constant = 12;
        }else{
            _selectImageButtonLeft.constant = space + (space + kImageViewWidth) * _upLoadIamgeMutableArray.count;
        }
    }else{
        _selectImageButton.hidden = YES;
    }
    
}
- (IBAction)submitFeedbackClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.userInteractionEnabled = NO;
    __weak __typeof(self) wealSelf = self;
    if (_upLoadIamgeMutableArray.count > 0) {
        __block int count = 0;
        NSMutableArray *urlArr = [[NSMutableArray alloc]initWithCapacity:0];
        [self.view znt_showHUD:nil];
        for (UIImage *image in _upLoadIamgeMutableArray) {
            [CLMineNetworking clUploadImages:@[image] witheType:@{@"type":@(1)} complete:^(NSMutableDictionary *resultsObj) {
                if (resultsObj[@"data"] && resultsObj[@"data"][@"url"]) {
                    @synchronized (urlArr) {
                        [urlArr addObject:resultsObj[@"data"][@"url"]];
                        count = count + 1;
                        if (count == _upLoadIamgeMutableArray.count) {
                            [wealSelf submitFeedbackWithImagesUrl:urlArr];
                        }else{
                            _subButton.userInteractionEnabled = YES;
                        }
                    }
                }
            } theFailure:^(NSString *errorCode) {
                count = count + 1;
                if (count == _upLoadIamgeMutableArray.count) {
                    [wealSelf submitFeedbackWithImagesUrl:urlArr];
                }else{
                    _subButton.userInteractionEnabled = YES;
                }
            }];
        }
    }else{
        [self submitFeedbackWithImagesUrl:@[]];
        button.userInteractionEnabled = NO;
    }

}
-(void)submitFeedbackWithImagesUrl:(NSArray *)urls{
    __weak __typeof(self) wealSelf = self;
    CLFeedbackRequest *request = [[CLFeedbackRequest alloc]init];
    request.content = _feedbackTextView.text;
    request.mobile = _phoneText.text;
    request.images = urls;
    [CLMineNetworking feedback:request complete:^(NSMutableDictionary *resultsObj) {
        _subButton.userInteractionEnabled = YES;
        [wealSelf.view znt_showToast:@"提交成功"];
        [wealSelf.view znt_hideHUD];

    } theFailure:^(NSString *errorCode) {
        _subButton.userInteractionEnabled = YES;
        [wealSelf.view znt_showToast:errorCode];
        [wealSelf.view znt_hideHUD];
    }];
}
- (void)deletButtonClick:(UIButton *)button{
    [_upLoadIamgeMutableArray removeObjectAtIndex:button.tag - 2000];
    [self refreshImage];
}
- (IBAction)hideKeyboard:(id)sender {
    [_feedbackTextView resignFirstResponder];
    [_phoneText resignFirstResponder];
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
