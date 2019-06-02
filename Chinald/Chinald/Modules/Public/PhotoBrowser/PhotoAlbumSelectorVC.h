//
//  PhotoAlbumSelectorVC.h
//  PhotoBrowserDome
//
//  Created by WPFBob on 2019/5/18.
//  Copyright © 2019 wpf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "PhotoAlbumVC.h"
NS_ASSUME_NONNULL_BEGIN
@protocol PhotoSelectorCellDelegate;

@interface PhotoAlbumSelectorVC : UIViewController

@property (nonatomic, strong) NSArray<PHAsset *> *result;
@property (nonatomic, assign) int maxCount;
@property (nonatomic, copy) PhotoSelectCompletion completion;
@end
@interface PhotoSelectorCell : UICollectionViewCell
{
    IBOutlet UIButton *_selectBtn;
}

@property (nonatomic, weak) IBOutlet UIImageView *photoImageView;

@property (nonatomic, assign) id<PhotoSelectorCellDelegate> delegate;
@property (nonatomic, assign) BOOL choosed;
@property (nonatomic, strong) UIImage *image;

@end


@protocol PhotoSelectorCellDelegate <NSObject>

- (void)didSelected:(PhotoSelectorCell *)cell;
- (void)didUnSelected:(PhotoSelectorCell *)cell;

@end
NS_ASSUME_NONNULL_END
