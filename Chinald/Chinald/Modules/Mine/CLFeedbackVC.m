//
//  CLFeedbackVC.m
//  Chinald
//
//  Created by WPFBob on 2018/4/1.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLFeedbackVC.h"

@interface CLFeedbackVC ()
@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UILabel *numberOfStringLabel;
@property (strong, nonatomic) IBOutlet UIView *inputBackgroundView;

@end

@implementation CLFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我要吐槽";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewTextChange)name:UITextViewTextDidChangeNotification object:nil];
    _inputBackgroundView.layer.borderColor = [UIColor clDividingLineColor].CGColor;
}
#pragma mark =========== 监听输入框内容和键盘的显示、隐藏 ===========
- (void)textViewTextChange
{
    if (_feedbackTextView.text.length > 0) {
        _feedbackTextView.alpha = 1;
        if (_feedbackTextView.text.length >= 500 ) {
            _feedbackTextView.text = [_feedbackTextView.text substringToIndex:500];
            _numberOfStringLabel.text = @"500/500";

        }else{
            _numberOfStringLabel.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)_feedbackTextView.text.length];
        }
    }else{
        _feedbackTextView.alpha = 0.7;
        _numberOfStringLabel.text = @"0/500";
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
