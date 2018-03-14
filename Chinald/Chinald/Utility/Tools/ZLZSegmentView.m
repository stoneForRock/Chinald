//
//  QASegmentView.m
//  DGroupBusiness
//
//  Created by 曾昭英 on 2017/3/7.
//  Copyright © 2017年 Dachen Tech. All rights reserved.
//

#import "ZLZSegmentView.h"
#import "UIView+ZNTAdd.h"
#import "ZLZGradientMaskView.h"

#define kSegmentWidth ScreenFullWidth
#define kSegmentHeight 44

#define kIndicatorLength 30

#define kTintColor ThemeColor

@implementation ZLZSegmentView
{
    UIView *_indicator;
    NSMutableArray *_segmentButtons;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setHasShadow:(BOOL)hasShadow {
    _hasShadow = hasShadow;
    if (hasShadow) {
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowColor = LineColor.CGColor;
        self.layer.shadowOpacity = .3;
    }
}

- (void)setSegmentTitles:(NSArray<NSString *> *)titles
{
    self.titles = titles;
    
    if (_segmentButtons.count > 0) {
        [_segmentButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    _segmentButtons = [NSMutableArray arrayWithCapacity:titles.count];
    CGFloat varLength = kSegmentWidth/titles.count;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:obj forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:ThemeColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.frame = CGRectMake(varLength*idx, 0, varLength, kSegmentHeight);
        button.tag = idx;
        [button addTarget:self action:@selector(segmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_segmentButtons addObject:button];
        button.selected = idx==0;
    }];
    
    if (!_indicator) {
        _indicator = [[UIView alloc] initWithFrame:CGRectMake((varLength-kIndicatorLength)/2, kSegmentHeight - 2, kIndicatorLength, 2)];
        _indicator.backgroundColor = ThemeColor;
        [self addSubview:_indicator];
    }
}

- (IBAction)segmentButtonAction:(UIButton *)sender {
    [self setSegmentSelectedIndex:sender.tag animated:YES];
}

- (void)setSegmentSelectedIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self setSegmentSelectedIndexNoDelegate:index animated:animated];
    [self.delegate segmentView:self didSelectIndex:self.selectedIndex];
}

- (void)setSegmentSelectedIndexNoDelegate:(NSUInteger)index animated:(BOOL)animated{
    if (self.selectedIndex == index) {
        return;
    }
    
    [_segmentButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            obj.selected = YES;
        } else {
            obj.selected = NO;
        }
    }];
    
    CGFloat varLength = kSegmentWidth/_segmentButtons.count;
    [UIView animateWithDuration:animated?.2:0 animations:^{
//        _indicator.frame = CGRectMake(index*varLength, 42, varLength, 2);
        _indicator.znt_left = index*varLength+(varLength-kIndicatorLength)/2;
    }];
    
    self.selectedIndex = index;
}

@end
