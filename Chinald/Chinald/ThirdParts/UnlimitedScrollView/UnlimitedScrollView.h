//
//  UnlimitedScrollView.h
//  weiGuanJia
//
//  Created by 张东文 on 14-5-9.
//  Copyright (c) 2014年 张东文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMPageControl.h"

@class UnlimitedScrollView;

@protocol UnlimitedScrollViewDelegate <NSObject>
@optional

- (void)clickWithPage:(NSInteger)intPage view:(UnlimitedScrollView *)unlimitedScrollView;

@end

@interface UnlimitedScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView *scrollView_;
    NSArray *arrData_;
    BOOL isScroll_;
    NSTimer *time_;
    
    UILabel *labelNumMin_;
    UILabel *labelNumMax_;
}

@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, weak)id <UnlimitedScrollViewDelegate>delegate;
@property(nonatomic, strong)RMPageControl *pageControl;
@property(nonatomic, strong)UIView *viewPageNum;

// (3-1-2-3-1)
- (void)addViewWithArray:(NSArray *)arr;

@end
