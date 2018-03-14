//
//  ZNTPublicMacro.h
//  ICOCShipper
//
//  Created by shichuang on 2017/9/3.
//  Copyright © 2017年 Intelligent Circulate Of Cement Tech. All rights reserved.
//

#ifndef ZNTPublicMacro_h
#define ZNTPublicMacro_h

#define kPageSize 20

// Tools
#define ZNTWeak(x) __weak __typeof__(x) __weak_##x##__ = x;
#define ZNTStrong(x) __typeof__(x) x = __weak_##x##__;

#define dispatch_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define INSTANCE_XIB_H +(instancetype)instanceFromXib;
#define INSTANCE_XIB_M(s,c) \
+ (instancetype)instanceFromXib {\
return [[UIStoryboard storyboardWithName:s bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([c class])];\
}

//系统
#ifndef kSystemVersion
#define kSystemVersion [UIDevice currentDevice].systemVersion.doubleValue
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

//尺寸
#define ScreenBounds [[UIScreen mainScreen] bounds]     //屏幕
#define ScreenFullHeight [[UIScreen mainScreen] bounds].size.height //屏幕高度
#define ScreenFullWidth [[UIScreen mainScreen] bounds].size.width   //屏幕宽度
#define StatusBarHeight 20.0        //状态栏高度
#define NavigationBarHeight 44.0    //导航栏高度
#define TabBarHeight 49.0           //标签栏高度
#define ToolBarHeight 44.0          //工具栏高度
#define NumKeyboardHeight 208.0      //键盘高度
#define SearchAreaHeight 54.0        //搜索框高度
#define MainHeight ScreenFullHeight - StatusBarHeight //主屏幕高度

//使用RGBA值构建Color,其中RGB值分别除以255
#define BOSCOLORWITHRGBADIVIDE255(_RED,_GREEN,_BLUE,_ALPHA) [UIColor colorWithRed:_RED/255.0 green:_GREEN/255.0 blue:_BLUE/255.0 alpha:_ALPHA]

#define BOSCOLORWITHRGBA(rgbValue, alphaValue)		[UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
green:((float)(((rgbValue) & 0x00FF00) >> 8))/255.0 \
blue:((float)((rgbValue) & 0x0000FF))/255.0 \
alpha:(alphaValue)]

#if DEBUG
#define BOSAssert(condition, desc) NSAssert(condition, desc);
#define BOSAssert1(condition, desc, arg1) NSAssert1(condition, desc, arg1);
#define BOSAssert2(condition, desc, arg1, arg2) NSAssert2(condition, desc, arg1, arg2);
#define BOSAssert3(condition, desc, arg1, arg2, arg3) NSAssert3(condition, desc, arg1, arg2, arg3);
#define BOSAssert4(condition, desc, arg1, arg2, arg3, arg4) NSAssert4(condition, desc, arg1, arg2, arg3, arg4);
#define BOSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5) NSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5);
#else
#define BOSAssert(condition, desc)
#define BOSAssert1(condition, desc, arg1)
#define BOSAssert2(condition, desc, arg1, arg2)
#define BOSAssert3(condition, desc, arg1, arg2, arg3)
#define BOSAssert4(condition, desc, arg1, arg2, arg3, arg4)
#define BOSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5)
#endif



#endif
