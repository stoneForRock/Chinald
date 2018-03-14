//
//  ZNTUploadImageManager.m
//  ZNTShipper
//
//  Created by shichuang on 2017/9/7.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import "ZNTUploadImageManager.h"
#import "ZNTQiniuOperator.h"

@implementation ZNTUploadImageManager

+ (ZNTUploadImageManager *)shared {
    static dispatch_once_t once;
    static ZNTUploadImageManager *shareManager;
    dispatch_once(&once, ^{
        shareManager = [[self alloc] init];
    });
    return shareManager;
}

- (void)uploadImageWithQiniuSpace:(NSString *)space image:(UIImage *)image uploadImageComplete:(UploadImageComplete)uploadImageComplete {
    NSData * data = [self imageData:image];
    ZNTQiniuOperator *operator = [[ZNTQiniuOperator alloc] init];
    [operator qiuNiuUpWithProgressWithBucket:space fileData:data fileType:@"1" fileName:@"default" CallBack:^(BOOL success, id responseObject, NSError *error)
     {
         if (success)
         {
             NSString *url = responseObject[@"url"];
             if (uploadImageComplete) {
                 uploadImageComplete(YES,url,@"上传图片成功");
             }
         }
         else
         {
             if (uploadImageComplete) {
                 uploadImageComplete(NO,nil,@"上传图片失败");
             }
         }
     }ProgressCallBack:nil KeyCallBack:nil];
    
}

-(NSData *)imageData:(UIImage *)myimage{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>500*1024) {
        if (data.length>1024*1024) {
            //1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}

@end
