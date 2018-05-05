//
//  CLFeedbackVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/1.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLFeedbackVC.h"
#import "UIImage+EIPUploadImage.h"
#import "TZImagePickerController.h"
#import <AVFoundation/AVFoundation.h>

@interface CLFeedbackVC ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UILabel *numberOfStringLabel;
@property (strong, nonatomic) IBOutlet UIView *inputBackgroundView;
@property(nonatomic, strong) NSMutableArray *imagesArray; //!<
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addImageButtonTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addImageButtonLeft;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *addImageTitleLabel;

@end

@implementation CLFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNotification];
    [self initUI];
    [self initData];
}
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewTextChange)name:UITextViewTextDidChangeNotification object:nil];
}
-(void)initUI{
    self.title = @"我要吐槽";
    _inputBackgroundView.layer.borderColor = [UIColor clDividingLineColor].CGColor;
}
-(void)initData{
    _imagesArray = [[NSMutableArray alloc]initWithCapacity:0];
}

- (IBAction)chooseImageButtonClick:(id)sender {
    
    //从相册选择图片
    [self getImageFromAlbum];
//    UIButton *button = (UIButton *)sender;
//
//    UIAlertController *selectAlertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        UIPopoverPresentationController *popPresenter = [selectAlertController popoverPresentationController];
//        popPresenter.sourceView = button;
//        popPresenter.sourceRect = button.bounds;
//        [self presentViewController:selectAlertController animated:YES completion:nil];
//
//    }else{
//        [self presentViewController:selectAlertController animated:YES completion:nil];
//    }
//    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //从相册选择图片
//        [self getImageFromAlbum];
//    }];
//    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //从相机拍照选择
//        NSString *mediaType = AVMediaTypeVideo;
//        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
//            UIAlertController *cameraPermissionsAlertController = [UIAlertController alertControllerWithTitle:@"相机访问受限，请在设置\\隐私\\相机中打开票税宝相机访问权限" message:nil preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:cameraPermissionsAlertController animated:YES completion:nil];
//            UIAlertAction * enterAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//            }];
//            [cameraPermissionsAlertController addAction:enterAction];
//        }else{
//            [self pickImageFromCamera];
//        }
//    }];
//    UIAlertAction *escAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [albumAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
//    [cameraAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
//    [escAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
//    [selectAlertController addAction:albumAction];
//    [selectAlertController addAction:cameraAction];
//    [selectAlertController addAction:escAction];
}
#pragma mark----------- 从相册选择图片
-(void)getImageFromAlbum
{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:5 - _imagesArray.count delegate:self];
    //禁止选择原图和视频
    imagePickerVC.allowPickingOriginalPhoto = NO;
    imagePickerVC.allowPickingVideo = NO;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (UIImage *image in photos) {
            UIImage *image1 = [UIImage clCompressImageQuality:image toByte:300 * 1000];
            [_imagesArray addObject:image1];
        }
        int imageViewNumberOneLine = ScreenFullWidth > 320 ? 4 : 3;
        float space = (ScreenFullWidth - 24 - 80 * imageViewNumberOneLine) / (float)(imageViewNumberOneLine - 1);
        for (int i = 0; i < _imagesArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.image = _imagesArray[i];
            [_contentView addSubview:imageView];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_addImageTitleLabel.mas_bottom).with.offset(14 + 90 * (i / imageViewNumberOneLine));
                make.left.equalTo(_contentView.mas_left).with.offset(12 + ((80 + space) * (i % imageViewNumberOneLine)));
                make.width.mas_offset(80);
                make.height.mas_offset(80);
            }];
        }
        
        _addImageButtonTop.constant = 14 + 90 * (_imagesArray.count / imageViewNumberOneLine);
        
        _addImageButtonLeft.constant = 12 + ((80 + space) * (_imagesArray.count % imageViewNumberOneLine));
        
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];

}


#pragma mark 从摄像头获取活动图片
- (void)pickImageFromCamera
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&[mediatypes count]>0){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        //        imagePicker = [[UIImagePickerController alloc] init];
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
