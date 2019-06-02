//
//  PhotoAlbumVC.h
//  PhotoBrowserDome
//
//  Created by WPFBob on 2019/5/18.
//  Copyright © 2019 wpf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PhotoSelectCompletion)(NSArray *list);

@interface PhotoAlbumVC : UIViewController
@property (nonatomic, assign) int maxCount;
@property (nonatomic, copy) PhotoSelectCompletion completion;

/**
 弹出相册
 
 @param controller 从controller弹出
 @param maxCount 最大可选数量
 @param completion 选择完成的回调
 */
+ (void)showFromViewController:(UIViewController *)controller maxCount:(int)maxCount completion:(PhotoSelectCompletion)completion;
@end
@interface PhotoAlbumCell : UITableViewCell
{
    IBOutlet UIImageView *_iconImageView;
    IBOutlet UILabel *_titleLabel;
    IBOutlet UILabel *_descLabel;
}

- (void)setTitle:(NSString *)title desc:(NSString *)desc image:(UIImage *)image;

@end
NS_ASSUME_NONNULL_END
