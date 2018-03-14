//
//  ZNTQiniuOperator.m
//  ICOCCarOwners
//
//  Created by shichuang on 2017/1/16.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTQiniuOperator.h"
#import "UniqueIdentificationTool.h"
#import "QN_GTM_Base64.h"
#include <CommonCrypto/CommonCrypto.h>
#import "NSDictionary+ZNTAdd.h"
#import "NSString+ZNTAdd.h"

@implementation ZNTQiniuOperator

/**
 *七牛上传获取上传进度方法  bucket为上传到七牛的对应空间
 *				 fileData为需要上传的文件data
 *				 fileType为需要上传的文件类型 （1代表图片  2代表语音  3代表视频 4其他）
 *               fileName为文件名称，和图片路径有关，应该和用户id和图片用处绑定到一起
 *				 callBack为需要上传上传成功回调
 *				 progressCallBack为上传进度回调
 */
-(void)qiuNiuUpWithProgressWithBucket:(NSString	*)bucket
                             fileData:(NSData	*)fileData
                             fileType:(NSString	*)fileType
                             fileName:(NSString *)fileName
                             CallBack:(ZLZFinishBlock)callBack
                     ProgressCallBack:(CSPQNProgressCallBack)progressCallBack
                          KeyCallBack:(CSPCallBackKey)callBackKey
{
    
    //生成唯一的uuid成为对应的上传key
    NSString	*key = [[NSString uuidString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 第一步 从服务端获取七牛的token
    if (callBackKey) {
        callBackKey(key); //将key回调出去
    }
    
    self.cancelled = NO; //取消上传函数
    
    //服务端获取的token
    NSString	*upToken = [self makeTokenWithAccessKey:ZNTQiniuAccessKey secretKey:ZNTQiniuSecretKey bucket:bucket key:key];
    
//    NSString	*domain = responseObject[@"data"][@"domain"];
    // 第二步 上传到七牛服务器
    QNUploadManager *upManager = [[QNUploadManager	alloc]init];
    
    //这一步是上传进度回调
    QNUploadOption *opt = [[QNUploadOption alloc]initWithMime:nil progressHandler:^(NSString *key, float percent) {
        if (progressCallBack) {
            progressCallBack(key,percent);
        }
        
    } params:nil checkCrc:NO cancellationSignal:^BOOL(){
        return self.cancelled;
    }];
    
    //上传是否成功 回调
    [upManager putData:fileData key:key token:upToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
     {
        if (resp[@"key"] && info.ok) {
            //上传成功获取到的七牛url（由key和指定的地址拼接而成）
            NSString	*url = [NSString stringWithFormat:@"%@%@",[ZNTQiniuOperator defaultQiNiuUrlWithPath:bucket],resp[@"key"]];;
            
            NSMutableDictionary	*callBackDict = [[NSMutableDictionary	alloc]init];
            [callBackDict setValue:url forKey:@"url"];
            
            
            if ([fileType integerValue] == qiNiuTypeImage) {//图片回调
                UIImage *image = [UIImage imageWithData:fileData];
                CGSize	size = image.size;
                int width = ceilf(size.width*1.0);
                int height = ceilf(size.height*1.0);
                NSString	*kindImage = [ZNTQiniuOperator typeForImageData:fileData];
                [callBackDict setValue:[NSString stringWithFormat:@"%d",width] forKey:@"imageWidth"];
                [callBackDict setValue:[NSString stringWithFormat:@"%d",height] forKey:@"imageHeight"];
                [callBackDict setValue:kindImage forKey:@"format"];
                [callBackDict setValue:key forKey:@"key"];
            }else{
                [callBackDict setValue:key forKey:@"key"];
            }
            if (callBack) {
                callBack(YES,callBackDict,nil);
            }
            
        }else{
            if (callBack) {
                callBack(NO,nil,nil);
            }
        }
    } option:opt];
}

+(NSString	*)defaultQiNiuUrlWithPath:(NSString	*)bucket
{
    if ([bucket isEqualToString:qiNiuOrderSpace])
    {
        return @"http://ojarnmszw.bkt.clouddn.com/";
    }else if ([bucket isEqualToString:qiNiuAccountSpace])
    {
        return @"http://ojarb9zz7.bkt.clouddn.com/";
        
    }else if ([bucket isEqualToString:qiNiuDeafultSpace])
    {
        return @"http://ojaq592h6.bkt.clouddn.com/";
    }else
    {
        return @"";
    }
}

+ (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return nil;
}


- (NSString *)makeTokenWithAccessKey:(NSString *)accessKey secretKey:(NSString *)secretKey bucket:(NSString *) bucket key:(NSString *) key
{
    const char *secretKeyStr = [secretKey UTF8String];
    
    NSString *policy = [self marshalBucket:bucket key:key];
    
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedPolicy = [QN_GTM_Base64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    
    NSString *encodedDigest = [QN_GTM_Base64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",accessKey, encodedDigest, encodedPolicy];
    
    return token;
}

- (NSString *)marshalBucket:(NSString *) bucket key:(NSString *) key
{
    time_t deadline;
    time(&deadline);//返回当前系统时间
    
    deadline += (self.expires > 0) ? self.expires : 3600; // +3600秒,即默认token保存1小时.
    
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //users是我开辟的公共空间名（即bucket），aaa是文件的key，
    //按七牛“上传策略”的描述：    <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，若已存在同名资源则会被覆盖。如果只希望上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
    //所以如果参数只传users的话，下次上传key还是aaa的文件会提示存在同名文件，不能上传。
    //传users:aaa的话，可以覆盖更新，但实测延迟较长，我上传同名新文件上去，下载下来的还是老文件。
    [dic setObject:[NSString stringWithFormat:@"%@:%@",bucket,key] forKey:@"scope"];//根据
    
    [dic setObject:deadlineNumber forKey:@"deadline"];
    
    NSString *json = [dic toJSONString];
    
    return json;
}


@end
