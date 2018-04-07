//
//  CLOrderOperationItemViewBase.m
//  Chinald
//
//  Created by WPFBob on 2018/4/5.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLOrderOperationItemViewBase.h"

@implementation CLOrderOperationItemViewBase
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addItems];
    }
    return self;
}
-(void)addItems{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
