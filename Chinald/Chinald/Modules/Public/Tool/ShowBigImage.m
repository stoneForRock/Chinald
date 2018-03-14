//
//  ShowBigImage.m
//  DGroupPatient
//
//  Created by 张东文 on 15/7/21.
//  Copyright (c) 2015年 Dachen Tech. All rights reserved.
//

#import "ShowBigImage.h"
#import "AppDelegate.h"

@interface ShowBigImage()
@property (nonatomic, strong) UIView *toolBarView;

@end

@implementation ShowBigImage

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight)];
    self.backgroundColor = [UIColor blackColor];
    
    scrollView_ = [[UIScrollView alloc] initWithFrame:self.frame];
    scrollView_.backgroundColor = [UIColor clearColor];
    scrollView_.pagingEnabled = YES;
    scrollView_.showsHorizontalScrollIndicator = NO;
    scrollView_.delegate = self;
    scrollView_.tag = 1000;
    [self addSubview:scrollView_];
    
    labelNumber_ = [[UILabel alloc] initWithFrame:CGRectMake((ScreenFullWidth - 40)/2, ScreenFullHeight - 30, 40, 20)];
    labelNumber_.textColor = [UIColor whiteColor];
    labelNumber_.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    labelNumber_.font = [UIFont systemFontOfSize:14];
    labelNumber_.textAlignment = NSTextAlignmentCenter;
    labelNumber_.layer.cornerRadius = 3;
    labelNumber_.clipsToBounds = YES;
    [self addSubview:labelNumber_];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTap:)];
    [scrollView_ addGestureRecognizer:tap];
    
    self.toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenFullHeight - 44, ScreenFullWidth, 44)];
    self.toolBarView.hidden = YES;
    self.toolBarView.backgroundColor = ThemeTextColor;
    [self addSubview:self.toolBarView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(hiden) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = Font15;
    backBtn.frame = CGRectMake(0, 0, 80, 44);
    [self.toolBarView addSubview:backBtn];
    
    UIButton *reUploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reUploadBtn setTitle:@"重新上传" forState:UIControlStateNormal];
    [reUploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [reUploadBtn addTarget:self action:@selector(reUploadAction) forControlEvents:UIControlEventTouchUpInside];
    reUploadBtn.titleLabel.font = Font15;
    reUploadBtn.frame = CGRectMake(ScreenFullWidth - 80, 0, 80, 44);
    [self.toolBarView addSubview:reUploadBtn];
    
    return self;
}

- (void)setShowStyle:(ShowBigImageStyle)showStyle {
    self.toolBarView.hidden = (showStyle == ShowBigImageNormalStyle);
}

- (void)reUploadAction {
    if (self.bigImagedelegate != nil && [self.bigImagedelegate respondsToSelector:@selector(reUploadImageAction:)]) {
        [self.bigImagedelegate reUploadImageAction:self];
    }
    [self hiden];
}

- (void)showWithImage:(id)image;
{
    labelNumber_.hidden = YES;
    [self showWithImageArr:@[image] index:0];
}

- (void)showWithImageArr:(NSArray *)arrImage index:(NSInteger)intIndex
{
    [scrollView_.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < arrImage.count; i++)
    {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(i * ScreenFullWidth, 0, ScreenFullWidth, ScreenFullHeight)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 1.0;
        scrollView.delegate = self;
        [scrollView_ addSubview:scrollView];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenFullWidth, ScreenFullHeight)];
        img.tag = 100;
        img.contentMode = UIViewContentModeScaleAspectFit;
        if ([arrImage[i] isKindOfClass:[NSString class]])
        {
            [img sd_setImageWithURL:[NSURL URLWithString:arrImage[i]]];
        }
        else
        {
            img.image = arrImage[i];
        }
        [scrollView addSubview:img];
    }
    
    scrollView_.contentSize = CGSizeMake(arrImage.count * ScreenFullWidth, ScreenFullHeight);
    scrollView_.contentOffset = CGPointMake(intIndex * ScreenFullWidth, 0);
    labelNumber_.text = [NSString stringWithFormat:@"%ld-%ld",arrImage.count,intIndex + 1];
    
    [[ZNTAppDelegate window] addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^
    {
        self.alpha = 1;
        
    }];
}

#pragma mark - UITapGestureRecognizer

- (void)touchTap:(UITapGestureRecognizer *)tap
{
    [self hiden];
}

- (void)hiden {
    [self removeFromSuperview];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:100];
}

// 滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1000)
    {
        // 滚动页数
        NSInteger count = scrollView.contentSize.width / scrollView.frame.size.width;
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        NSLog(@"%ld",page);
        labelNumber_.text = [NSString stringWithFormat:@"%ld-%ld",count,page + 1];
    }
    
}

@end
