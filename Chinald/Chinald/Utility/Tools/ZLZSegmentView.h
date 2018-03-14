//
//  QASegmentView.h
//  DGroupBusiness
//
//  Created by 曾昭英 on 2017/3/7.
//  Copyright © 2017年 Dachen Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLZSegmentView;
@protocol ZLZSegmentViewDelegate <NSObject>
- (void)segmentView:(ZLZSegmentView *)segmentView didSelectIndex:(NSUInteger)index;
@end

@interface ZLZSegmentView : UIView

@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic, strong) NSArray <NSString *>* titles;
@property (nonatomic) BOOL hasShadow;

@property (weak, nonatomic) IBOutlet id<ZLZSegmentViewDelegate> delegate;

- (void)setSegmentTitles:(NSArray <NSString *>*)titles; // init
- (void)setSegmentSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSegmentSelectedIndexNoDelegate:(NSUInteger)index animated:(BOOL)animated;

@end
