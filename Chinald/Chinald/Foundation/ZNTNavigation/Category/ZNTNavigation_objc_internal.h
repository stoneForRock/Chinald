//
//  ZNTNavigation_objc_internal.h
//  ZNTShipper
//
//  Created by shichuang on 2017/9/5.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#ifndef ZNTNavigation_objc_internal_h
#define ZNTNavigation_objc_internal_h

#import <objc/runtime.h>

#define znt_getProperty(objc,key) [objc valueForKey:key]

@protocol ZNTExtensionBarProtocol <NSObject>

@property (nonatomic, assign) CGSize znt_size;
- (UIView * _Nullable)znt_backgroundView;
- (CGSize)znt_sizeThatFits:(CGSize)size;
@end


#define ZNTExtensionBarImplementation \
- (CGSize)znt_sizeThatFits:(CGSize)size { \
CGSize newSize = [self znt_sizeThatFits:size]; \
return CGSizeMake(self.znt_size.width == 0.f ? newSize.width : self.znt_size.width, self.znt_size.height == 0.f ? newSize.height : self.znt_size.height); \
} \
- (void)setZnt_size:(CGSize)size { \
objc_setAssociatedObject(self, @selector(znt_size), [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN_NONATOMIC); \
[self sizeToFit]; \
} \
- (CGSize)znt_size { \
return [objc_getAssociatedObject(self, _cmd) CGSizeValue]; \
} \
- (UIView *)znt_backgroundView { \
return znt_getProperty(self, @"_backgroundView"); \
}


#endif /* ZNTNavigation_objc_internal_h */
