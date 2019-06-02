//
//  PhotoAlbumBrowser.h
//  PhotoBrowserDome
//
//  Created by WPFBob on 2019/5/18.
//  Copyright © 2019 wpf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ImageViewDelegate;

@interface ImageView : UIScrollView

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, assign) id<ImageViewDelegate> idelegate;

+ (CGRect)fitImgeWithSize:(CGSize)imageSize tagerSize:(CGSize)targetSize onlyScaleToSmall:(BOOL)onlyScaleToSmall;

@end
@protocol ImageViewDelegate

- (void)didSelectImageView:(ImageView *)imageView;

@end

@protocol PhotoAlbumBrowserDelegate;

@interface PhotoAlbumBrowser : UIViewController

@property (nonatomic, assign) int maxCount;
@property (nonatomic, assign) id<PhotoAlbumBrowserDelegate> delegate;
@property (nonatomic, assign) BOOL isSendMode;

- (void)showInRect:(CGRect)rect;
- (void)addSelectedIndex:(int)index;

@end

@protocol PhotoAlbumBrowserDelegate <NSObject>

@required
- (int)numberOfImages:(PhotoAlbumBrowser *)PhotoAlbumBrowser;
- (int)indexOfCurrent:(PhotoAlbumBrowser *)PhotoAlbumBrowser;
- (UIImage *)imageForIndex:(int)index sender:(PhotoAlbumBrowser *)PhotoAlbumBrowser;

@optional
- (CGRect)rectOfDisappear:(PhotoAlbumBrowser *)PhotoAlbumBrowser currentIndex:(int)index;
- (void)didSelectImages:(PhotoAlbumBrowser *)PhotoAlbumBrowser imageIndexs:(NSArray *)list;
- (void)didSendImages:(PhotoAlbumBrowser *)PhotoAlbumBrowser;

@end

NS_ASSUME_NONNULL_END
