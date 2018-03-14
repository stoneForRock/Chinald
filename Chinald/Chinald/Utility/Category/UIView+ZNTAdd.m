//
//  UIView+ZNTAdd.m
//  ICOCShipper
//
//  Created by shichuang on 2017/9/4.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "UIView+ZNTAdd.h"
#import "ZLZNoDataView.h"

@implementation UIView (ZNTAdd)
- (CGPoint) znt_origin
{
    return self.frame.origin;
}

- (void) setZnt_origin:(CGPoint)aPoint {
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGSize) znt_size
{
    return self.frame.size;
}

- (void) setZnt_size: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

- (CGFloat) znt_height
{
    return self.frame.size.height;
}

- (void) setZnt_height: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) znt_width
{
    return self.frame.size.width;
}

- (void) setZnt_width: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) znt_top
{
    return self.frame.origin.y;
}

- (void) setZnt_top: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) znt_left
{
    return self.frame.origin.x;
}

- (void) setZnt_left: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) znt_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setZnt_bottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) znt_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setZnt_right: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

- (void)setZnt_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)znt_x
{
    return self.frame.origin.x;
}

- (void)setZnt_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)znt_y
{
    return self.frame.origin.y;
}

- (CGFloat)znt_max_X{
    return CGRectGetMaxX(self.frame);
}
- (void)setZnt_max_X:(CGFloat)max_X{}


- (CGFloat)znt_max_Y{
    return CGRectGetMaxY(self.frame);
}
- (void)setZnt_max_Y:(CGFloat)max_Y{}


- (void)setZnt_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)znt_centerX
{
    return self.center.x;
}

- (void)setZnt_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)znt_centerY
{
    return self.center.y;
}

- (UIView *)znt_addLineAtRect:(CGRect)rect {
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = LineColor;
    [self addSubview:line];
    return line;
}

- (void)setRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setDefaultShadow {
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowColor = LineColor.CGColor;
    self.layer.shadowOpacity = 1;
}

- (UITableView *)getSuperTableView {
    if (self.superview) {
        if ([self.superview isKindOfClass:[UITableView class]]) {
            return (UITableView *)self.superview;
        } else {
            return [self.superview getSuperTableView];
        }
    } else {
        return nil;
    }
}

#define kNoDataViewTag 1200012

- (void)znt_showNoDataView:(NSString *)text
{
    ZLZNoDataView *noDataView = [self viewWithTag:kNoDataViewTag];
    if (!noDataView) {
        noDataView = [[[UINib nibWithNibName:@"ZLZNoDataView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        noDataView.frame = CGRectMake((self.znt_width-240)/2, (self.znt_height-240)/2, 240, 240);
        [self addSubview:noDataView];
        noDataView.tag = kNoDataViewTag;
    }
    if (text) {
        noDataView.alertTextLabel.text = text;
    }
    noDataView.hidden = NO;
}

- (void)znt_hideNoDataView
{
    ZLZNoDataView *noDataView = [self viewWithTag:kNoDataViewTag];
    if (noDataView) {
        noDataView.hidden = YES;
    }
}

#define kContentLoadingViewTag 1300013

- (void)znt_showContentLoadingView
{
    UIView *loadingView = [self viewWithTag:kContentLoadingViewTag];
    if (!loadingView) {
        loadingView = [[[UINib nibWithNibName:@"zntContentLoadingView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        CGSize viewSize = loadingView.znt_size;
        loadingView.frame = CGRectMake((self.znt_width-viewSize.width)/2, (self.znt_height-viewSize.height)/2, viewSize.width, viewSize.height);
        [self addSubview:loadingView];
        loadingView.tag = kContentLoadingViewTag;
    }
    loadingView.hidden = NO;
}

- (void)znt_hideContentLoadingView
{
    UIView *loadingView = [self viewWithTag:kContentLoadingViewTag];
    if (loadingView) {
        loadingView.hidden = YES;
    }
}
@end
