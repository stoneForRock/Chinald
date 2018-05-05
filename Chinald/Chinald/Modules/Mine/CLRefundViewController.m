//
//  CLRefundViewController.m
//  Chinald
//
//  Created by WPFBob on 2018/4/7.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLRefundViewController.h"
#import "UIImage+EIPUploadImage.h"
#import "TZImagePickerController.h"
#import <AVFoundation/AVFoundation.h>
@interface CLRefundViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,TZImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addImageButtonTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addImageButtonLeft;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *addImageTitleLabel;
@property(nonatomic, assign) BOOL acceptAgreement;  //!<
@property(nonatomic, strong) NSMutableArray *imagesArray; //!<

@end

@implementation CLRefundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
}
-(void)initData{
    _acceptAgreement = YES;
    _imagesArray = [[NSMutableArray alloc]initWithCapacity:0];
}
- (IBAction)acceptRefundAgreement:(id)sender {
    _acceptAgreement = !_acceptAgreement;
    UIButton *button = (UIButton *)sender;
    [button setImage:[UIImage imageNamed:_acceptAgreement ? @"icon_address_default" : @"icon_address_no_default"] forState:0];
}

- (IBAction)chooseImageButtonClick:(id)sender {
    
    //从相册选择图片
    [self getImageFromAlbum];
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
