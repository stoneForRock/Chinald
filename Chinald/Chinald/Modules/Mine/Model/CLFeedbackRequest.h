//
//  CLFeedbackRequest.h
//  Chinald
//
//  Created by WPFBob on 2019/5/23.
//  Copyright © 2019 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLFeedbackRequest : JSONModel
@property(nonatomic, copy)NSString *content;  //!<吐槽内容
@property(nonatomic, strong)NSArray *images;  //!<图片（完整图片url，多个用英文逗号分割）
@property(nonatomic, copy)NSString *mobile;  //!<手机号
@end

NS_ASSUME_NONNULL_END
