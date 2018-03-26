//
//  CLMainPageListModel.h
//  Chinald
//
//  Created by dachen on 2018/3/26.
//  Copyright © 2018年 HuaYing. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CLMainPageListModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *goodsId;
@property (nonatomic, copy) NSString<Optional> *goodsTitle;
@property (nonatomic, copy) NSString<Optional> *desc;
@property (nonatomic, copy) NSString<Optional> *price;
@property (nonatomic, copy) NSString<Optional> *commentCount;

@end

@interface CLBannerModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *bannerId;
@property (nonatomic, copy) NSString<Optional> *bannerUrl;

@end
