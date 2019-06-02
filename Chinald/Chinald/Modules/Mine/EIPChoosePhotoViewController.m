//
//  TIBGetEntryInvoiceDataViewController.m
//  taxinvoicebox
//
//  Created by WPFBob on 2017/8/8.
//  Copyright © 2017年 vanvy. All rights reserved.
//

#import "EIPChoosePhotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+fixOrientation.h"
#import "UIImage+UploadImage.h"
#define ORIGINAL_MAX_WIDTH 640.0f

@interface EIPChoosePhotoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIScrollViewDelegate>
{
    UIImagePickerController *_imagePickerController;
    UIViewController *_listViewController;
    UIImage *_selectImage;
    UIImageView *_imageView;
    UIView *_backView;
}
@end

@implementation EIPChoosePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}
-(void)seletTheImageFormAlert:(UIViewController *)viewController AlertTitle:(NSString *)titleString{
    _listViewController  = viewController;
    _imagePickerController = [[UIImagePickerController alloc]init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;


    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [viewController presentViewController:alertController animated:YES completion:nil];
    UIAlertAction *selectCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.allowsEditing = YES;

        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
        _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        
        [viewController presentViewController:self animated:NO completion:^{
            [self presentViewController:_imagePickerController animated:NO completion:nil];

        }];
        
    }];
    UIAlertAction *photoAlbumAction = [UIAlertAction actionWithTitle:@"我的相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (_isCropperImage) {
            _imagePickerController.allowsEditing = YES;
            
        }else{
            _imagePickerController.allowsEditing = NO;
            
        }
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
        [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        _imagePickerController.mediaTypes = mediaTypes;
        [viewController presentViewController:self animated:NO completion:^{
            [self presentViewController:_imagePickerController animated:NO completion:nil];
        }];

    }];
    UIAlertAction *escAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [selectCameraAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
    [photoAlbumAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
    [escAction setValue:[UIColor colorWithHexRGB:@"0x007AFF"] forKey:@"_titleTextColor"];
    [alertController addAction:selectCameraAction];
    [alertController addAction:photoAlbumAction];
    [alertController addAction:escAction];
    
}

#pragma mark =========== 从摄像头获取图片 UIImagePickerControllerDelegate===========
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    
    if (_isCropperImage) {
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
        _selectImage = [image fixOrientation];

        self.entryInvoiceDataBlock([UIImage clCompressImageQuality:_selectImage toByte:250000]);

    }else{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _selectImage = image;
        _selectImage = [_selectImage fixOrientation];

        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
            self.entryInvoiceDataBlock([UIImage clCompressImageQuality:_selectImage toByte:250000]);
//            self.entryInvoiceDataBlock(image);

        }else{
            _backView = [[UIView alloc] init];
            _backView.backgroundColor = [UIColor blackColor];
            [_imagePickerController.view addSubview:_backView];
            [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.left.mas_offset(0);
                make.right.mas_offset(0);
                make.bottom.mas_offset(0);
            }];
            UIScrollView *scrollView = [[UIScrollView alloc] init];
            scrollView.delegate = self;
            scrollView.maximumZoomScale = 3.0;
            scrollView.minimumZoomScale = 0.7;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            [_backView addSubview:scrollView];
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.left.mas_offset(0);
                make.right.mas_offset(0);
                make.bottom.mas_offset(0);
            }];
            NSLog(@"image.imageOrientation===%ld",(long)_selectImage.imageOrientation);
            _imageView = [[UIImageView alloc]init];
            _imageView.center = CGPointMake(ScreenFullWidth / 2.0, ScreenFullHeight / 2.0);
            _imageView.bounds = CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight - 100);
            _imageView.image = _selectImage;
            _imageView.contentMode = UIViewContentModeScaleAspectFit;

            [scrollView addSubview:_imageView];
            
            NSLog(@"image.imageOrientation===%ld",(long)_selectImage.imageOrientation);
            UIView *buttonBackView = [[UIView alloc]init];
            buttonBackView.backgroundColor = [UIColor grayColor];
            buttonBackView.alpha = 0.3;
            [_backView addSubview:buttonBackView];
            [buttonBackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(0);
                make.right.mas_offset(0);
                make.bottom.mas_offset(0);
                make.height.mas_offset(ScreenFullHeight > 800 ? 49 + 34 : 49);
            }];
            
            UIButton *escButton = [[UIButton alloc] init];
            [escButton setTitleColor:[UIColor whiteColor] forState:0];
            [escButton setTitle:@"取消" forState:0];
            escButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            escButton.titleLabel.font = [UIFont systemFontOfSize:17];
            [escButton addTarget:self action:@selector(escButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:escButton];
            [escButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(0);
                make.width.mas_offset(100);
                make.bottom.mas_offset(ScreenFullHeight > 800 ? -34 : 0);
                make.height.mas_offset(49);
            }];
            
            UIButton *sureButton = [[UIButton alloc] init];
            [sureButton setTitleColor:[UIColor whiteColor] forState:0];
            [sureButton setTitle:@"完成" forState:0];
            sureButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:sureButton];
            [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(0);
                make.width.mas_offset(100);
                make.bottom.mas_offset(ScreenFullHeight > 800 ? -34 : 0);
                make.height.mas_offset(49);
            }];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(escButtonClick)];
            [_backView addGestureRecognizer:tap];
        }
    }

}
-(void)escButtonClick{
    [_backView removeFromSuperview];
}

-(void)sureButtonClick{
    [_backView removeFromSuperview];
    self.entryInvoiceDataBlock([UIImage clCompressImageQuality:_selectImage toByte:300000]);

}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView

{
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    //目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点为屏幕中点，此种情况确保图像在屏幕中心。
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    _imageView.center = CGPointMake(xcenter, ycenter);

////    if (<#condition#>) {
////        <#statements#>
////    }
//    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(30 + (SECREEN_HEIGHT - SECREEN_HEIGHT * scrollView.zoomScale) / 2.0);
//        make.left.mas_offset(30 + (SECREEN_WIDTH - SECREEN_WIDTH * scrollView.zoomScale) / 2.0);
//        make.width.mas_offset(SECREEN_WIDTH * scrollView.zoomScale);
//        make.height.mas_offset(SECREEN_HEIGHT * scrollView.zoomScale);
//    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [_listViewController dismissViewControllerAnimated:YES completion:nil];
    
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
