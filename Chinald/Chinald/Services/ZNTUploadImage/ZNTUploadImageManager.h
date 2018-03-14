//
//  ZNTUploadImageManager.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/7.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UploadImageComplete)(BOOL success,NSString *newProfileUrl,NSString *errorMsg);


@interface ZNTUploadImageManager : NSObject

+ (ZNTUploadImageManager *)shared;

- (void)uploadImageWithQiniuSpace:(NSString *)space
                            image:(UIImage *)image
              uploadImageComplete:(UploadImageComplete)uploadImageComplete;

@end
