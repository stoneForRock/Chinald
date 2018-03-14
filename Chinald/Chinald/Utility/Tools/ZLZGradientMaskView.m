//
//  QAGradientMaskView.m
//  MedicalCircle
//
//  Created by 曾昭英 on 2017/5/8.
//  Copyright © 2017年 Dachen Tech. All rights reserved.
//

#import "ZLZGradientMaskView.h"

@implementation ZLZGradientMaskView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addMaskView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addMaskView];
}

- (void)addMaskView {
    self.userInteractionEnabled = NO;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    dispatch_async(dispatch_get_main_queue(), ^{
        gradient.frame = self.bounds;
    });
    
    gradient.colors = @[(__bridge id)UIColor.whiteColor.CGColor,
                        (__bridge id)UIColor.clearColor.CGColor];
    
    gradient.locations = @[@0,@1];
    self.layer.mask = gradient;
    
    self.maskLayer = gradient;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
