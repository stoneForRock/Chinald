//
//  PhotoAlbumBrowser.m
//  PhotoBrowserDome
//
//  Created by WPFBob on 2019/5/18.
//  Copyright © 2019 wpf. All rights reserved.
//
#define kMinScan 1.0
#define kMaxScan 3.0
#define SPACE 18
#define IMAGESCACHEMAX 10
#define ANIMATEDURATION 0.3

#import "PhotoAlbumBrowser.h"
@interface ImageCountView : UIView

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *label;

- (void)drawWithImage:(NSString *)imageName leftCapWidth:(float)x topCapHeight:(float)y;

@end

@implementation ImageCountView
@synthesize text = _text;
@synthesize imageView = _imageView;
@synthesize label = _label;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        if (!_imageView)
        {
            UIImageView *image = [[UIImageView alloc] init];
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:13];
            
            [self addSubview:image];
            [self addSubview:label];
            
            self.imageView = image;
            self.label = label;
            
//            [image release];
//            [label release];
        }
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        if (!_imageView)
        {
            UIImageView *image = [[UIImageView alloc] init];
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:13];
            
            [self addSubview:image];
            [self addSubview:label];
            
            self.imageView = image;
            self.label = label;
            
//            [image release];
//            [label release];
        }
    }
    
    return self;
}

- (void)dealloc
{
//    [_text release];
//    [_imageView release];
//    [_label release];
//
//    [super dealloc];
}

- (void)drawWithImage:(NSString *)imageName leftCapWidth:(float)x topCapHeight:(float)y
{
    _label.text = _text;
    float width = [_text sizeWithAttributes:@{NSFontAttributeName:_label.font}].width + 13;
    UIImage *back = [UIImage imageNamed:imageName];
    width = width < back.size.width ? back.size.width : width;
    _imageView.frame = CGRectMake(0, 0, width, back.size.height);
    _imageView.image = [back stretchableImageWithLeftCapWidth:x topCapHeight:y];
    _label.frame = CGRectMake(0, 0, width, back.size.height);
    
    CGRect rect = self.frame;
    rect.size.width = _imageView.frame.size.width;
    rect.size.height = _imageView.frame.size.height;
    rect.origin.x += self.frame.size.width - rect.size.width;
    self.frame = rect;
}

- (void)setText:(NSString *)text
{
//    [_text release];
//    _text = [text retain];
    
    [self drawWithImage:@"picnumber.png" leftCapWidth:13 topCapHeight:14];
    if ([text intValue] == 0)
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
    }
}

@end



@interface ImageView () <UIScrollViewDelegate>
{
    float maxScan;
}

@property (nonatomic, retain) UIImageView *imageView;

- (void)resizeImage;

@end

static BOOL __isClosing = NO;

@implementation ImageView
@synthesize idelegate = _idelegate;
@synthesize image = _image;
@synthesize imageView = _imageView;

+ (CGRect)fitImgeWithSize:(CGSize)imageSize tagerSize:(CGSize)targetSize onlyScaleToSmall:(BOOL)onlyScaleToSmall
{
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = width;
    CGFloat scaledHeight = height;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
        {
            scaleFactor = widthFactor;
        }
        else
        {
            scaleFactor = heightFactor;
        }
        
        if (scaleFactor < 1 || (scaleFactor > 1 && !onlyScaleToSmall))
        {
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
        }
        
        thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        if (thumbnailPoint.x < 0)
        {
            thumbnailPoint.x = 0;
        }
        if (thumbnailPoint.y < 0)
        {
            thumbnailPoint.y = 0;
        }
    }
    
    return CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        maxScan = kMaxScan;
        
        self.delegate = self;
        self.minimumZoomScale = kMinScan;
        self.maximumZoomScale = maxScan;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:imageView];
        self.imageView = imageView;
        self.imageView.userInteractionEnabled = YES;
       //[imageView release];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    if (image != _image)
    {
        //[_image release];
        if (!image)
        {
            image = [UIImage imageNamed:@"DownImg.png"];
        }
        //_image = [image retain];
        
        CGRect rect = [ImageView fitImgeWithSize:image.size tagerSize:self.frame.size onlyScaleToSmall:YES];
        if (rect.size.width < image.size.width)
        {
            float scan = image.size.width / rect.size.width;
            maxScan = scan < kMaxScan ? kMaxScan : scan;
        }
        else
        {
            maxScan = kMaxScan;
        }
        _imageView.frame = rect;
        _imageView.image = image;
        
        if (self.zoomScale != 1)
        {
            self.zoomScale = 1;
        }
        
        self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        
    }
}

- (void)resizeImage
{
    if (self.zoomScale != 1)
    {
        self.zoomScale = 1;
    }
    
    CGRect rect = [ImageView fitImgeWithSize:_image.size tagerSize:self.frame.size onlyScaleToSmall:YES];
    if (rect.size.width < _image.size.width)
    {
        float scan = _image.size.width / rect.size.width;
        maxScan = scan < kMaxScan ? kMaxScan : scan;
    }
    else
    {
        maxScan = kMaxScan;
    }
    _imageView.frame = rect;
    
    self.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    
    
}

#pragma mark -
#pragma mark === UIScrollView Delegate ===
#pragma mark -
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat xcenter = scrollView.frame.size.width / 2 , ycenter = scrollView.frame.size.height / 2;
    // 目前contentsize的width是否大于原scrollview的contentsize，如果大于，设置imageview中心x点为 contentsize的一半，以固定imageview在该contentsize中心。如果不大于说明图像的宽还没有超出屏幕范围，可继续让中心x点 为屏幕中点，此种情况确保图像在屏幕中心。
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width / 2 : xcenter;
    //同上，此处修改y值
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height / 2 : ycenter;
    [_imageView setCenter:CGPointMake(xcenter, ycenter)];
}

#pragma mark -
#pragma mark === UITouch Delegate ===
#pragma mark -
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    switch (touch.tapCount)
    {
        case 1:
        {
            __isClosing = YES;
            [self performSelector:@selector(singleClick) withObject:nil afterDelay:0.2];
            break;
        }
        case 2:
        {
            __isClosing = NO;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(singleClick) object:nil];
            [self doubleClick];
            break;
        }
        default:
            break;
    }
}

- (void)singleClick
{
    [_idelegate didSelectImageView:self];
}

- (void)doubleClick
{
    CGFloat zs = self.zoomScale;
    zs = (zs == kMinScan) ? maxScan : kMinScan;
    
    [UIView animateWithDuration:ANIMATEDURATION animations:^
     {
         self.zoomScale = zs;
     }];
}

#pragma mark -
#pragma mark === dealloc ===
#pragma mark -
- (void)dealloc
{
//    [_image release];
//    [_imageView release];
//
//    [super dealloc];
}

@end


@interface PhotoAlbumBrowser ()<UIScrollViewDelegate, ImageViewDelegate>
{
    int page;
    int count;
    CGRect startRect;
    NSInteger curentIndex;
    BOOL isRelayerout;
}
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *botView;
@property (nonatomic, retain) UIImageView *chosenBtnBack;
@property (nonatomic, retain) ImageCountView *imageCountView;
@property (nonatomic, retain) NSMutableDictionary *imagesCache;
@property (nonatomic, retain) NSMutableArray *selectedIndexs;
@end
static UIWindow *__imageWindow;

@implementation PhotoAlbumBrowser
//@synthesize delegate = _delegate;
//@synthesize isSendMode = _isSendMode;
//@synthesize scrollView = _scrollView;
//@synthesize botView = _botView;
//@synthesize chosenBtnBack = _chosenBtnBack;
//@synthesize imageCountView = _imageCountView;
//@synthesize imagesCache = _imagesCache;
//@synthesize selectedIndexs = _selectedIndexs;
- (id)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor blackColor];
        __isClosing = NO;
        self.imagesCache = [NSMutableDictionary dictionary];
        self.selectedIndexs = [NSMutableArray array];
    }
    
    return self;
}

- (UIImage *)getImageWithIndex:(int)index
{
    //    UIImage *image = [_imagesCache objectForKey:[NSNumber numberWithInt:index]];
    //    if (!image)
    //    {
    //        image = [_delegate imageForIndex:index sender:self];
    //        if (_imagesCache.allKeys.count >= IMAGESCACHEMAX)
    //        {
    //            int removeIndex = index - IMAGESCACHEMAX;
    //            if ([_imagesCache objectForKey:[NSNumber numberWithInt:removeIndex]])
    //            {
    //                [_imagesCache removeObjectForKey:[NSNumber numberWithInt:removeIndex]];
    //            }
    //            removeIndex = index + IMAGESCACHEMAX;
    //            if ([_imagesCache objectForKey:[NSNumber numberWithInt:removeIndex]])
    //            {
    //                [_imagesCache removeObjectForKey:[NSNumber numberWithInt:removeIndex]];
    //            }
    //        }
    //        if (!image)
    //        {
    //            image = [UIImage imageNamed:@"DownImg.png"];
    //        }
    //        [_imagesCache setObject:image forKey:[NSNumber numberWithInt:index]];
    //    }
    //
    //    return image;
    return [_delegate imageForIndex:index sender:self];
}

- (void)setChosen:(BOOL)chosen
{
    if (chosen)
    {
        _chosenBtnBack.image = [UIImage imageNamed:@"choose.png"];
    }
    else
    {
        _chosenBtnBack.image = [UIImage imageNamed:@"unchoose.png"];
    }
}

- (void)sendFile:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectImages:imageIndexs:)])
    {
        if (_selectedIndexs.count > 0)
        {
            [_delegate didSelectImages:self imageIndexs:[NSArray arrayWithArray:_selectedIndexs]];
        }
        else
        {
            [_delegate didSelectImages:self imageIndexs:[NSArray arrayWithObject:[NSNumber numberWithInt:page]]];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(didSendImages:)])
    {
        [_delegate didSendImages:self];
    }
    
    [self close];
}

- (void)choose:(id)sender
{
    if ([_selectedIndexs indexOfObject:[NSNumber numberWithInt:page]] == NSNotFound)
    {
        if (_selectedIndexs.count >= _maxCount)
        {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"只能选择%d张图片", _maxCount] preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertVC animated:YES completion:nil];
            return;
        }
        [self setChosen:YES];
        [_selectedIndexs addObject:[NSNumber numberWithInt:page]];
    }
    else
    {
        [self setChosen:NO];
        [_selectedIndexs removeObject:[NSNumber numberWithInt:page]];
    }
    _imageCountView.text = [NSString stringWithFormat:@"%lu", (unsigned long)_selectedIndexs.count];
    
    _chosenBtnBack.frame = CGRectMake(20, 14, 21, 21);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         _chosenBtnBack.frame = CGRectMake(10, 4, 42, 42);
     } completion:nil];
    _imageCountView.imageView.frame = CGRectMake(_imageCountView.frame.size.width / 4, _imageCountView.frame.size.height / 4, _imageCountView.frame.size.width / 2, _imageCountView.frame.size.height / 2);
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
         _imageCountView.imageView.frame = CGRectMake(0, 0, _imageCountView.frame.size.width, _imageCountView.frame.size.height);
     } completion:nil];
}

- (void)addSelectedIndex:(int)index
{
    if (_isSendMode && [_selectedIndexs indexOfObject:[NSNumber numberWithInt:index]] == NSNotFound)
    {
        [_selectedIndexs addObject:[NSNumber numberWithInt:index]];
        _imageCountView.text = [NSString stringWithFormat:@"%lu", (unsigned long)_selectedIndexs.count];
    }
}

- (void)reLayerout
{
    _scrollView.frame = CGRectMake(0 - SPACE, 0, self.view.frame.size.width + SPACE, self.view.frame.size.height);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * count, _scrollView.frame.size.height);
    
    int i1 = -1;
    int i2 = -1;
    int i3 = -1;
    if (count == 1)
    {
        i1 = 0;
    }
    if (count == 2)
    {
        i1 = 0;
        i2 = 1;
    }
    else
    {
        if (page == 0)
        {
            i1 = 0;
            i2 = 1;
            i3 = 2;
        }
        else if (page == count - 1)
        {
            i1 = page - 2;
            i2 = page - 1;
            i3 = page;
        }
        else
        {
            i1 = page - 1;
            i2 = page;
            i3 = page + 1;
        }
    }
    int temp[3] = {i1, i2, i3};
    int contentCount = count > 3 ? 3 : count;
    for (int i = 0; i < contentCount; i++)
    {
        ImageView *imageView = (ImageView *)[self.view viewWithTag:i + 1];
        imageView.frame = CGRectMake(SPACE + (_scrollView.frame.size.width * temp[i]), 0, _scrollView.frame.size.width - SPACE, _scrollView.frame.size.height);
        [imageView resizeImage];
    }
    
    if (page == count - 1)
    {
        _scrollView.contentOffset = CGPointMake(_scrollView.contentSize.width - _scrollView.frame.size.width, 0);
    }
    else if (page > 0)
    {
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * page, 0);
    }
}

- (void)initial
{
    for (UIView *sub in self.view.subviews)
    {
        [sub removeFromSuperview];
    }
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 - SPACE, 0, self.view.frame.size.width + SPACE, self.view.frame.size.height)];
    //scrollView.scrollEnabled = NO;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * count, scrollView.frame.size.height);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //[scrollView release];
    
    if (_isSendMode)
    {
        UIView *botView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
        botView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        botView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UIImageView *chosenBtnBack = [[UIImageView alloc] initWithFrame:CGRectMake(10, 4, 42, 42)];
        chosenBtnBack.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        chosenBtnBack.image = [UIImage imageNamed:@"unchoose.png"];
        [botView addSubview:chosenBtnBack];
        self.chosenBtnBack = chosenBtnBack;
        //[chosenBtnBack release];
        UIButton *choose = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, 42, 42)];
        choose.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [choose addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [botView addSubview:choose];
        //[choose release];
        UIButton *send = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 62, 10, 62, 30)];
        send.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [send setTitleColor:[UIColor colorWithRed:42 / 255.0 green:215 / 255.0 blue:53 / 255.0 alpha:1] forState:UIControlStateNormal];
        send.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        send.titleLabel.font = [UIFont systemFontOfSize:16];
        [send setTitle:@"完成" forState:UIControlStateNormal];
        [send addTarget:self action:@selector(sendFile:) forControlEvents:UIControlEventTouchUpInside];
        [botView addSubview:send];
       // [send release];
        ImageCountView *countView = [[ImageCountView alloc] initWithFrame:CGRectMake(send.frame.origin.x, 11, 27, 28)];
        countView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        countView.text = @"0";
        [botView addSubview:countView];
        self.imageCountView = countView;
        // [countView release];
        [self.view addSubview:botView];
        self.botView = botView;
        // [botView release];
        
        if (_selectedIndexs.count > 0)
        {
            if ([_selectedIndexs indexOfObject:[NSNumber numberWithInt:page]] != NSNotFound)
            {
                [self setChosen:YES];
            }
            _imageCountView.text = [NSString stringWithFormat:@"%lu", (unsigned long)_selectedIndexs.count];
        }
    }
    
    int i1 = -1;
    int i2 = -1;
    int i3 = -1;
    if (count == 1)
    {
        i1 = 0;
    }
    if (count == 2)
    {
        i1 = 0;
        i2 = 1;
    }
    else
    {
        if (page == 0)
        {
            i1 = 0;
            i2 = 1;
            i3 = 2;
        }
        else if (page == count - 1)
        {
            i1 = page - 2;
            i2 = page - 1;
            i3 = page;
        }
        else
        {
            i1 = page - 1;
            i2 = page;
            i3 = page + 1;
        }
    }
    int temp[3] = {i1, i2, i3};
    int contentCount = count > 3 ? 3 : count;
    for (int i = 0; i < contentCount; i++)
    {
        ImageView *imageView = [[ImageView alloc] initWithFrame:CGRectMake(SPACE + (scrollView.frame.size.width * temp[i]), 0, _scrollView.frame.size.width - SPACE, _scrollView.frame.size.height)];
        imageView.tag = i + 1;
        imageView.image = [self getImageWithIndex:temp[i]];
        imageView.idelegate = self;
        [_scrollView addSubview:imageView];
        // [imageView release];
    }
    if (page == count - 1)
    {
        _scrollView.contentOffset = CGPointMake(_scrollView.contentSize.width - _scrollView.frame.size.width, 0);
    }
    else if (page > 0)
    {
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * page, 0);
    }
}

- (void)showInRect:(CGRect)rect
{
    count = [_delegate numberOfImages:self];
    page = [_delegate indexOfCurrent:self];
    startRect = rect;
    curentIndex = -1;
    
    if (page < 0 || page >= count)
    {
        return;
    }
    
    UIWindow *window = nil;
    if (!__imageWindow)
    {
        __imageWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        __imageWindow.windowLevel = UIWindowLevelStatusBar + 1.f;
        __imageWindow.hidden = NO;
    }
    window = __imageWindow;
    window.rootViewController = self;
    self.view.frame = rect;
    UIImage *image = [self getImageWithIndex:page];
    UIImageView *temp = [[UIImageView alloc] init];
    //temp.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.clipsToBounds = YES;
    if (image.size.width < image.size.height)
    {
        CGFloat height = rect.size.width / image.size.width * image.size.height;
        temp.frame = CGRectMake(0, -(height - rect.size.height) / 2, rect.size.width, height);
    }
    else
    {
        CGFloat width = rect.size.height / image.size.height * image.size.width;
        temp.frame = CGRectMake(-(width - rect.size.width) / 2, 0, width, rect.size.height);
    }
    temp.image = image;
    [self.view addSubview:temp];
    // [temp release];
    
    [UIView animateWithDuration:ANIMATEDURATION animations:^
     {
         self.view.frame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height);
         temp.frame = [ImageView fitImgeWithSize:image.size tagerSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height) onlyScaleToSmall:YES];
     } completion:^(BOOL finished)
     {
         [self initial];
     }];
}

- (void)didSelectImageView:(ImageView *)imageView
{
    self.view.userInteractionEnabled = NO;
    if (_isSendMode)
    {
        [_botView removeFromSuperview];
    }
    
    UIImage *image = imageView.image;
    UIImageView *temp = [[UIImageView alloc] initWithFrame:[imageView convertRect:imageView.imageView.frame toView:self.view]];
    temp.image = image;
    [self.view addSubview:temp];
    // [temp release];
    [_scrollView removeFromSuperview];
    
    [UIView animateWithDuration:ANIMATEDURATION animations:^
     {
         if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
         {
             [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:@(UIInterfaceOrientationPortrait)];
         }
         
         CGRect viewRect;
         if (_delegate && [_delegate respondsToSelector:@selector(rectOfDisappear:currentIndex:)])
         {
             viewRect = [_delegate rectOfDisappear:self currentIndex:page];
         }
         else
         {
             viewRect = startRect;
         }
         if (viewRect.origin.x == 0 && viewRect.origin.y == 0 && viewRect.size.width == 0 && viewRect.size.height == 0)
         {
             CGRect rect = [UIApplication sharedApplication].delegate.window.frame;
             viewRect = CGRectMake(0 - rect.size.width / 2, 0 - rect.size.height / 2, rect.size.width * 2, rect.size.height * 2);
             self.view.alpha = 0;
         }
         //CGRect imageRect = [ImageView fitImgeWithSize:image.size tagerSize:viewRect.size onlyScaleToSmall:NO];
         //viewRect = CGRectMake(viewRect.origin.x + imageRect.origin.x, viewRect.origin.y + imageRect.origin.y, imageRect.size.width, imageRect.size.height);
         //temp.frame = CGRectMake(0, 0, imageRect.size.width, imageRect.size.height);
         self.view.frame = viewRect;
         if (image.size.width < image.size.height)
         {
             CGFloat height = viewRect.size.width / image.size.width * image.size.height;
             temp.frame = CGRectMake(0, -(height - viewRect.size.height) / 2, viewRect.size.width, height);
         }
         else
         {
             CGFloat width = viewRect.size.height / image.size.height * image.size.width;
             temp.frame = CGRectMake(-(width - viewRect.size.width) / 2, 0, width, viewRect.size.height);
         }
     } completion:^(BOOL finished)
     {
         if (_delegate && [_delegate respondsToSelector:@selector(didSelectImages:imageIndexs:)])
         {
             [_delegate didSelectImages:self imageIndexs:[NSArray arrayWithArray:_selectedIndexs]];
         }
         
         [self close];
     }];
}

- (void)close
{
    if (__imageWindow)
    {
        __imageWindow.hidden = YES;
        //[__imageWindow release];
        __imageWindow = nil;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    for (UIView *sub in scrollView.subviews)
    {
        if ([sub isKindOfClass:[ImageView class]])
        {
            __isClosing = NO;
            [NSObject cancelPreviousPerformRequestsWithTarget:sub selector:@selector(singleClick) object:nil];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isRelayerout)
    {
        return;
    }
    
    CGRect visibleBounds = scrollView.bounds;
    NSInteger index = (NSInteger)(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)));
    if (index < 0)
    {
        index = 0;
    }
    if (index > count - 1)
    {
        index = count - 1;
    }
    
    if (curentIndex == -1)
    {
        curentIndex = index;
    }
    
    if (curentIndex == index)
    {
        return;
    }
    
    NSInteger _currentIndex = curentIndex;
    curentIndex = index;
    
    if (index < _currentIndex)
    {
        page--;
        if (page <= 0)
        {
            page = 0;
        }
        
        if (_isSendMode)
        {
            if ([_selectedIndexs indexOfObject:[NSNumber numberWithInt:page]] == NSNotFound)
            {
                [self setChosen:NO];
            }
            else
            {
                [self setChosen:YES];
            }
        }
        
        if (page == 0 || page == count - 2)
        {
            return;
        }
        
        ImageView *lView = (ImageView *)[scrollView viewWithTag:1];
        ImageView *mView = (ImageView *)[scrollView viewWithTag:2];
        ImageView *rView = (ImageView *)[scrollView viewWithTag:3];
        rView.frame = CGRectMake(SPACE + scrollView.frame.size.width * (page - 1), 0, scrollView.frame.size.width - SPACE, scrollView.frame.size.height);
        rView.tag = 1;
        lView.tag = 2;
        mView.tag = 3;
        
        rView.image = [self getImageWithIndex:page - 1];
    }
    else if (index > _currentIndex)
    {
        page++;
        if (page >= count - 1)
        {
            page = count - 1;
        }
        
        if (_isSendMode)
        {
            if ([_selectedIndexs indexOfObject:[NSNumber numberWithInt:page]] == NSNotFound)
            {
                [self setChosen:NO];
            }
            else
            {
                [self setChosen:YES];
            }
        }
        
        if (page == count - 1|| page == 1)
        {
            return;
        }
        
        ImageView *lView = (ImageView *)[scrollView viewWithTag:1];
        ImageView *mView = (ImageView *)[scrollView viewWithTag:2];
        ImageView *rView = (ImageView *)[scrollView viewWithTag:3];
        lView.frame = CGRectMake(SPACE + scrollView.frame.size.width * (page + 1), 0, scrollView.frame.size.width - SPACE, scrollView.frame.size.height);
        mView.tag = 1;
        rView.tag = 2;
        lView.tag = 3;
        
        lView.image = [self getImageWithIndex:page + 1];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (__isClosing)
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    isRelayerout = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [self reLayerout];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    isRelayerout = NO;
}

- (void)dealloc
{
//    [_scrollView release];
//    [_botView release];
//    [_chosenBtnBack release];
//    [_imageCountView release];
//    [_imagesCache release];
//    [_selectedIndexs release];
    
//    [super dealloc];
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
