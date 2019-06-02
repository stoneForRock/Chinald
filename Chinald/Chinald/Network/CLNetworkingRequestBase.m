//
//  CLNetworkingRequestBase.m
//  taxinvoicebox
//
//  Created by WPFBob on 2017/7/27.
//  Copyright © 2017年 vanvy. All rights reserved.
//

#import "CLNetworkingRequestBase.h"
#import <AFNetworking.h>
static AFHTTPSessionManager *kHTTPSession;
static NSMutableArray *kRequestTaskArray;
static int refreshTokenCount = 0;
@implementation CLNetworkingRequestBase

//检查有无网络
+(BOOL)clTheNetworkStates{
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    switch (type) {
        case 1:
            
            return YES;
            
            break;
            
        case 2:
            
            return YES;
            break;
            
        case 3:
            
            return YES;
            break;
            
        case 5:
            
            return YES;
            break;
            
        default:
            
            return NO;//代表未知网络
            
            break;
    }
}

+(void)creatHTTPSessionIsHaveRequestHeader:(BOOL)isHave theSignature:(NSString *)signnatureStr{
    //共用session 提高网络请求速度   （不用每次都重新建立3次握手）
    
    if (!kRequestTaskArray) {
        kRequestTaskArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    
    kHTTPSession = [AFHTTPSessionManager manager];
    
    //设置请求数据的形式
//    AFJSONRequestSerializer *requestSerizlizer = [AFJSONRequestSerializer serializer];
//    kHTTPSession.requestSerializer = requestSerizlizer;
//    [kHTTPSession.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    kHTTPSession.requestSerializer = [AFHTTPRequestSerializer serializer];
    //设置请求头 Token、Platform、DeviceId、Latlng
    
    //设置请求超时
    [kHTTPSession.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    kHTTPSession.requestSerializer.timeoutInterval = 30.f;
    [kHTTPSession.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    
    //设置接收数据的形式
//    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
//    response.removesKeysWithNullValues = YES;
//    //AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
//    kHTTPSession.responseSerializer = response;
//    kHTTPSession.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];//设置接收的数据形式
    //kHTTPSession.responseSerializer.acceptableContentTypes = [kHTTPSession.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    kHTTPSession.responseSerializer = [AFHTTPResponseSerializer serializer];
}

//git 请求
+(void)clGetRequestTheURL:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * uploadProgress))progress theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary *  resultsObj))complete theFailure:(void(^)(NSString *  errorStr))theFailure{
    [self creatHTTPSessionIsHaveRequestHeader:have theSignature:nil];
    
    
    NSURLSessionDataTask *task = [kHTTPSession GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"url===%@=======responseObject====%@",urlStr,responseObject);
        if (complete) {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"url===%@===请求失败====%@",urlStr,error);
        
        if ([error.localizedDescription isEqualToString:@"已取消"] || [error.localizedDescription isEqualToString:@"cancelled"]) {
            theFailure(@"");
        }else{
            theFailure(error.localizedDescription);
        }
    }];
    [kRequestTaskArray addObject:task];
}

//post请求 带进度的
+(void)clPostRequestTheURL:(NSString *)urlStr parameters:(NSDictionary *)parameters progress:(void(^)(NSProgress * uploadProgress))progress  theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure{
    [self creatHTTPSessionIsHaveRequestHeader:have theSignature:nil];
    NSMutableDictionary *parameter = (NSMutableDictionary *)parameters;

    NSLog(@"发出去请求的数据是==%@",parameter);
    [parameter setValue:@"Ios" forKey:@"Platform"];
    
    NSURLSessionDataTask *task = [kHTTPSession POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              NSString *nameStr =  [[NSString alloc]initWithData: responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"url===%@===请求的结果====%@",urlStr,nameStr);
        
        
        if ([[responseObject objectForKey:@"ResCode"] intValue] == 1002){
            //去刷新token
            //成功刷新token后再获取数据
            [self eipRefreshTokenLastRequestURL:urlStr parameters:parameters Complete:^(NSMutableDictionary *resultsObj) {
                complete(resultsObj);
            } theFailure:^(NSString *errorStr) {
                theFailure(errorStr);
            }];
            
        }else if([[responseObject objectForKey:@"ResCode"] intValue] == 1000) {
            complete(responseObject);
        }else{
            theFailure([responseObject objectForKey:@"Msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"url===%@===请求失败====%@",urlStr,error);
        
        if ([error.localizedDescription isEqualToString:@"已取消"] || [error.localizedDescription isEqualToString:@"cancelled"]) {
            theFailure(@"");
            
        }else{
            theFailure(error.localizedDescription);
            
        }
    }];
    [kRequestTaskArray addObject:task];
    
}

//post请求无进度
+(void)clPostRequestTheURL:(NSString *)urlStr parameters:(NSDictionary *)parameters theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure{
    [self creatHTTPSessionIsHaveRequestHeader:have theSignature:nil];
    
    NSMutableDictionary *parameter = [parameters mutableCopy];

    NSURLSessionDataTask *task = [kHTTPSession POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject==%@",responseObject);
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:nil];
        NSLog(@"dic==%@",dic);

        if([[dic objectForKey:@"status"] intValue] == 1) {
            complete(dic);
        }else{
            theFailure([dic objectForKey:@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *errorRespomse = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
    NSLog(@"errorRespomse.statusCode==%ld",(long)errorRespomse.statusCode);
        NSLog(@"error.code==%ld",(long)error.code);
        
        if (errorRespomse.statusCode == 413) {
            theFailure(@"文件过大");
        }else if ( 500 == errorRespomse.statusCode || errorRespomse.statusCode == 501 || errorRespomse.statusCode == 502 || errorRespomse.statusCode == 503 || errorRespomse.statusCode == 505){
            theFailure(@"服务不可用");
        }else if ([error.localizedDescription isEqualToString:@"已取消"] || [error.localizedDescription isEqualToString:@"cancelled"]) {
            theFailure(@"");
        }else{
            NSLog(@"error.localizedDescription==%@",error.localizedDescription);
            theFailure(error.localizedDescription);
            
        }
    }];
    [kRequestTaskArray addObject:task];
    
}


/**
 post 请求  请求的数据类型是list
 @param urlStr  请求的URL
 @param parameters 请求的参数数据 用来获取加密验证
 @param have 是需要包含请求头token
 @param complete 时数据正确返回正确结果.
 @param theFailure  请求失败、服务器内部错误返回内容 请求返回的code等于998（登录验证错误）、999（未登录）通知弹出错误提醒，重新登录.
 */
+(void)clPostRequestTheURL:(NSString *)urlStr parametersArray:(NSMutableArray *)parameters theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure{
    
    [self creatHTTPSessionIsHaveRequestHeader:have theSignature:nil];
    
    
    NSURLSessionDataTask *task = [kHTTPSession POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"task.response===%@",task.response);
        NSLog(@"url===%@=======responseObject====%@",urlStr,responseObject);
        if([[responseObject objectForKey:@"ResCode"] intValue] == 1000) {
            complete(responseObject);
        }else{
            theFailure([responseObject objectForKey:@"Msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"url===%@===请求失败====%@",urlStr,error);
        NSHTTPURLResponse *errorRespomse = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.response"];
        
        if (errorRespomse.statusCode == 413) {
            theFailure(@"文件过大");
        }else if ( 500 == errorRespomse.statusCode || errorRespomse.statusCode == 501 || errorRespomse.statusCode == 502 || errorRespomse.statusCode == 503 || errorRespomse.statusCode == 505){
            theFailure(@"服务不可用");
        }else if ([error.localizedDescription isEqualToString:@"已取消"] || [error.localizedDescription isEqualToString:@"cancelled"]) {
            theFailure(@"");
        }else{
            theFailure(error.localizedDescription);
        }
        
    }];
    [kRequestTaskArray addObject:task];
}

+(void)clPostFormRequestTheUrl:(NSString *)urlStr parametersArray:(NSDictionary *)parameters theRequsetHeader:(BOOL)have complete:(void(^)(NSMutableDictionary * resultsObj))complete theFailure:(void(^)(NSString *errorStr))theFailure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        for (int i = 0; i < images.count; i++) {
//            NSData *data = [[NSData alloc]init];
//            NSString *fileName = @"";
//            if (images[i]) {
//                data = UIImageJPEGRepresentation(images[i], 0.85);
//                fileName = [NSString stringWithFormat:@"%@.%@",[[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] MD5],[UIImage clImageFormat:images[i]]];
//                [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"file%d",i+1] fileName:fileName mimeType:[UIImage clImageFormat:images[i]]];
//
//            }
//        }
//
        
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
 取消所有请求
 */
+(void)eipCancelAllOperations{
    [self creatHTTPSessionIsHaveRequestHeader:YES theSignature:nil];
    for (NSURLSessionDataTask *task in kRequestTaskArray) {
        [task cancel];
    }
    NSLog(@"取消了列表请求");
}
@end
