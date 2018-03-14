//
//  UnlimitedScrollView.m
//  weiGuanJia
//
//  Created by 张东文 on 14-5-9.
//  Copyright (c) 2014年 张东文. All rights reserved.
//

#import "UnlimitedScrollView.h"

@interface UnlimitedScrollView()

@end

@implementation UnlimitedScrollView
@synthesize scrollView = scrollView_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 15)];
        maskView.backgroundColor = [UIColor whiteColor];
        maskView.znt_top = 0;
        maskView.layer.shadowOffset = CGSizeMake(0, 2);
        maskView.layer.shadowColor = [UIColor colorWithHexRGB:@"ffffff"].CGColor;
        maskView.layer.shadowOpacity = .2;
        [self addSubview:maskView];
        
        scrollView_ = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 15)];
        scrollView_.znt_top = 0;
        scrollView_.showsVerticalScrollIndicator = NO;
        scrollView_.backgroundColor = [UIColor clearColor];
        [scrollView_ setShowsHorizontalScrollIndicator:NO];
        scrollView_.pagingEnabled = YES;
        scrollView_.delegate = self;
        scrollView_.layer.cornerRadius = 2;
        [self addSubview:scrollView_];
        
        _pageControl = [[RMPageControl alloc] initWithFrame:CGRectMake(200, scrollView_.znt_bottom, 40, 15)];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.enabled = NO;
        [self addSubview:_pageControl];
        
        _viewPageNum = [[UIView alloc] initWithFrame:CGRectMake(0, self.znt_height-20, 40, 20)];
        _viewPageNum.backgroundColor = [UIColor clearColor];
        _viewPageNum.hidden = YES;
        labelNumMin_ = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        labelNumMin_.textAlignment = NSTextAlignmentRight;
        labelNumMin_.textColor = [UIColor whiteColor];
        labelNumMin_.font = [UIFont systemFontOfSize:14];
        labelNumMin_.backgroundColor = [UIColor clearColor];
        [_viewPageNum addSubview:labelNumMin_];
        labelNumMax_ = [[UILabel alloc] initWithFrame:CGRectMake(labelNumMin_.znt_right, 0, 20, 20)];
        [_viewPageNum addSubview:labelNumMax_];
        labelNumMax_.textColor = [UIColor whiteColor];
        labelNumMax_.font = [UIFont systemFontOfSize:14];
        labelNumMax_.backgroundColor = [UIColor clearColor];
        [self addSubview:_viewPageNum];
    }
    return self;
}

- (void)addViewWithArray:(NSArray *)arr
{
    if (time_) {
        [time_ invalidate];
        time_ = nil;
    }
    [scrollView_.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    arrData_ = arr;
    
    for (int i = 0; i<arrData_.count; i++)
    {
        UIView *view = [arrData_ objectAtIndex:i];
        view.frame = CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height - 15);
        [scrollView_ addSubview:view];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = view.frame;
        
        if (i == 0)
        {
            btn.tag = i;
        }
        else if (i < arrData_.count - 1)
        {
            btn.tag = i - 1;
        }
        else
        {
            btn.tag = arrData_.count - 2;
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView_ addSubview:btn];
    }
    
    scrollView_.contentOffset  = CGPointMake(self.frame.size.width, 0);
    scrollView_.contentSize = CGSizeMake(self.frame.size.width*arrData_.count, scrollView_.frame.size.height);
    
    if (arrData_.count > 3) {
        _pageControl.hidden = NO;
        time_ = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(moveOffset) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:time_ forMode:NSRunLoopCommonModes];
    }else {
        scrollView_.contentOffset  = CGPointMake(0, 0);
        scrollView_.contentSize = CGSizeMake(self.frame.size.width, scrollView_.frame.size.height);
        _pageControl.hidden = YES;
    }
    
    isScroll_ = YES;
    
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = arrData_.count-2;
    _pageControl.znt_size = [_pageControl sizeForNumberOfPages:arrData_.count-2];
    //pageControl_.zlz_left = self.width - pageControl_.width - 10;
    _pageControl.znt_left = (ScreenFullWidth-_pageControl.znt_size.width)/2;
    _pageControl.znt_height = 15;
    
    labelNumMin_.text = [NSString stringWithFormat:@"1"];
    labelNumMax_.text = [NSString stringWithFormat:@"/%ld",arr.count-2];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    CGFloat x = scrollView.contentOffset.x;
    
    if (x <= 0)
    {
        scrollView_.contentOffset  = CGPointMake(self.frame.size.width*(arrData_.count-2), 0);
        _pageControl.currentPage = arrData_.count-3;
    }
    
    if (x >= self.frame.size.width * (arrData_.count - 1))
    {
        scrollView_.contentOffset  = CGPointMake(self.frame.size.width, 0);
        _pageControl.currentPage = 0;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    if (isScroll_)
    {
        isScroll_ = NO;
        [time_ invalidate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    if (!isScroll_)
    {
        if (arrData_.count > 3) {
            time_ = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(moveOffset) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:time_ forMode:NSRunLoopCommonModes];
        }
        isScroll_ = YES;
    }
    _pageControl.currentPage = scrollView.contentOffset.x/scrollView.znt_width-1;
    labelNumMin_.text = [NSString stringWithFormat:@"%ld",(NSInteger)(scrollView.contentOffset.x/scrollView.znt_width)];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    labelNumMin_.text = [NSString stringWithFormat:@"%ld",(NSInteger)(scrollView.contentOffset.x/scrollView.znt_width)];
}

- (void)moveOffset
{
    CGFloat x = roundf(scrollView_.contentOffset.x/self.frame.size.width)*self.frame.size.width;
    
    [scrollView_ setContentOffset:CGPointMake(x+self.frame.size.width, 0) animated:YES];
    
    NSInteger page = (int)((x+self.frame.size.width)/self.frame.size.width)-1;
    if (page>0 && page < arrData_.count)
    {
        _pageControl.currentPage = page;
    }
}

#pragma mark - 按钮事件

- (void)btnClick:(UIButton *)btn
{
    [_delegate clickWithPage:btn.tag view:self];
}

@end
