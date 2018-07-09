//
//  ZNTLoginRequest.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTLoginRequest.h"

@implementation ZNTLoginRequest

//验证码登录
+ (void)loginWithPhone:(NSString *)phone
              phoneCode:(NSString *)code
             onSuccess:(ZNTSuccessBlock)successBlock
             onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/user/login";
        request.parameters = @{@"phone":phone,@"code":code};
        request.httpMethod = kXMHTTPMethodPOST;

    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)loginWithPhone:(NSString *)telephone
              password:(NSString *)password
              userType:(NSString *)userType
             onSuccess:(ZNTSuccessBlock)successBlock
             onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/account/login";
        request.parameters = @{@"telephone":telephone,@"password":password,@"type":userType};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)loginAutoZNTOnSuccess:(ZNTSuccessBlock)successBlock
                    onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/account/loginAuto";
        request.parameters = @{@"token":ZNTData_Config.user.token};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)sendCodeWithPhone:(NSString *)phone codeType:(int)type
                onSuccess:(ZNTSuccessBlock)successBlock
                onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/user/code";
        request.parameters = @{@"phone":phone,@"type":[NSNumber numberWithInt:type]};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)sendCodeWithPhone:(NSString *)phone
                onSuccess:(ZNTSuccessBlock)successBlock
                onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/user/code";
        request.parameters = @{@"phone":phone};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)verifyCodeWithSmsId:(NSString *)smsId
                      phone:(NSString *)phone
                       code:(NSString *)code
                  onSuccess:(ZNTSuccessBlock)successBlock
                  onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/sms/verifyCode";
        request.parameters = @{@"smsId":smsId,@"phone":phone,@"code":code};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)updatePasswordWithPhone:(NSString *)phone
                           type:(NSString *)type
                            psw:(NSString *)pwd
                      onSuccess:(ZNTSuccessBlock)successBlock
                      onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/account/updatePwd";
        request.parameters = @{@"phone":phone,@"type":type,@"pwd":pwd};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)registCustomWithOwnerType:(NSString *)ownerType
                          phone:(NSString *)phone
                       password:(NSString *)password
                           name:(NSString *)name
                           card:(NSString *)card
                        cardPic:(NSString *)cardPic
                      onSuccess:(ZNTSuccessBlock)successBlock
                      onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/owner/regOwner";
        request.parameters = @{@"ownerType":ownerType,@"phone":phone,@"password":password,@"name":name,@"card":card,@"cardPic":cardPic};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)logoutWithAccountNum:(NSString *)accountNum
                    userType:(NSString *)userType
                   onSuccess:(ZNTSuccessBlock)successBlock
                   onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/account/logout";
        request.parameters = @{@"accountNum":accountNum,@"type":userType};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}

+ (void)updateAvatar:(NSString *)avatarUrl
           accountId:(NSString *)accountId
           onSuccess:(ZNTSuccessBlock)successBlock
           onFailure:(ZNTFailureBlock)failureBlock {
    [self sendRequest:^(XMRequest * _Nonnull request) {
        request.api = @"/znt2/account/updatePic";
        request.parameters = @{@"id":accountId,@"pic":avatarUrl};
        request.httpMethod = kXMHTTPMethodPOST;
    } onSuccess:^(id  _Nullable responseObject) {
        successBlock(responseObject);
        
    } onFailure:^(NSError * _Nullable error) {
        failureBlock(error);
    }];
}


@end
