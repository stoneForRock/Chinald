//
//  CLMineNetworking.m
//  Chinald
//
//  Created by WPFBob on 2018/4/15.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import "CLMineNetworking.h"
#import "ZNTURLPathManager.h"
#import "NSString+MD5.h"
#import "UIImage+UploadImage.h"
#import "CLTheGoodsAddressModel.h"
#import <JSONModel.h>
#import <AFNetworking.h>
@implementation CLMineNetworking
/**
 上传图片
 
 @param images 图片集
 @param parameters 上传的业务参数
 @param complete 上传结果
 @param theFailure 错误
 */
+ (void)clUploadImages:(NSArray *)images witheType:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSMutableDictionary *parameter = [parameters mutableCopy];
 
    NSString *urlStr = [NSString stringWithFormat:@"%@/index/uploadimg",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    [manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            NSData *data = [[NSData alloc]init];
            NSString *fileName = @"";
            if (images[i]) {
                data = UIImageJPEGRepresentation(images[i], 0.85);
                fileName = [NSString stringWithFormat:@"%@.%@",[[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] MD5],[UIImage clImageFormat:images[i]]];
                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"file%d",i+1] fileName:fileName mimeType:[UIImage clImageFormat:images[i]]];
                
            }
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"图片上传的结果是===%@",responseObject);
        if ([[responseObject objectForKey:@"status"] intValue] == 1) {
            complete(responseObject);
        }else{
            theFailure([responseObject objectForKey:@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"图片上传失败===%@",error);
        theFailure(error.localizedDescription);
    }];
    
}

/**
 修改用户信息
 
 @param parameters 参数  head_icon 头像url、name昵称 、open_phone是否公开手机号码 （1公开0不公开）都可选但不能为空
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)userEditInfo:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/user/editinfo",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:parameters theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}

/**
 修改手机号码
 
 @param parameters 参数 code 验证码 phone手机号
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)userChangePhone:(NSDictionary *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/user/changephone",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:parameters theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}

/**
 获取收货地址列表

 @param complete 成功
 @param theFailure 失败
 */
+ (void)addressIndexComplete:(void(^)(NSMutableArray *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/address/index",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:nil theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        NSMutableArray *array = [CLTheGoodsAddressModel arrayOfModelsFromDictionaries:resultsObj[@"data"] error:nil];
        complete(array);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}

/**
 添加收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressAdd:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSDictionary *dic = [parameters toDictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@/address/add",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:dic theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}

/**
 编辑收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressEdit:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSDictionary *dic = [parameters toDictionary];
    NSString *urlString = [NSString stringWithFormat:@"%@/address/edit",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:dic theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}

/**
 删除收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressDelete:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
   
    NSString *urlString = [NSString stringWithFormat:@"%@/address/delete",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:@{@"address_id":parameters.addressId} theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}

/**
 设置为默认收货地址
 @param parameters 收货地址信息
 @param complete 响应结果
 @param theFailure 错误信息
 */
+ (void)addressDefault:(CLTheGoodsAddressModel *)parameters complete:(void(^)(NSMutableDictionary *resultsObj))complete theFailure:(void(^)(NSString *errorCode))theFailure{
    NSString *urlString = [NSString stringWithFormat:@"%@/address/default",[ZNTURLPathManager sharedURLPathManager].baseUrl];
    [self clPostRequestTheURL:urlString parameters:@{@"address_id":parameters.addressId} theRequsetHeader:YES complete:^(NSMutableDictionary *resultsObj) {
        complete(resultsObj);
    } theFailure:^(NSString *errorStr) {
        theFailure(errorStr);
    }];
}
@end
