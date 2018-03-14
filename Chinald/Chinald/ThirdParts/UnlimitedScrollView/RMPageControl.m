//
//  RMPageControl.m
//  MedicalCircle
//
//  Created by 刘健 on 2017/6/19.
//  Copyright © 2017年 Dachen Tech. All rights reserved.
//

#import "RMPageControl.h"
#define dotW 4
#define magrin 6

@implementation RMPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) layoutSubviews{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        
        if (subviewIndex == self.currentPage)
        {
            size.height = 6;
            size.width = 6;
            subview.layer.cornerRadius = 3;
            subview.backgroundColor = [UIColor zntThemeTintColor];
            
            [subview setFrame:CGRectMake(subviewIndex * marginX, subview.frame.origin.y,
                                         
                                         size.width,size.height)];
        }else{
            size.height = 4;
            size.width = 4;
            subview.layer.cornerRadius = 2;
            subview.backgroundColor = [[UIColor zntThemeTintColor] colorWithAlphaComponent:0.5];
            
            [subview setFrame:CGRectMake(subviewIndex * marginX, subview.frame.origin.y+1,
                                         
                                         size.width,size.height)];
        }
    }
}

@end
