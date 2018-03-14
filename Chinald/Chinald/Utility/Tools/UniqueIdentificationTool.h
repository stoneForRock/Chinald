//
//  UniqueIdentificationTool.h
//  DGroupBusiness
//
//  Created by shichuang on 16/5/20.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGBKeyChain.h"

@interface UniqueIdentificationTool : NSObject

+ (void)saveUIID;

+ (id)readUIID;

+ (void)deleteUIID;

@end
