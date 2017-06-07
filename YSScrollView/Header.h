//
//  Header.h
//  YSScrollView
//
//  Created by 史晓义 on 2017/6/7.
//  Copyright © 2017年 史晓义. All rights reserved.
//

#ifndef Header_h
#define Header_h



#endif /* Header_h */

#import "UIView+YS.h"

#define SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)        //获取屏幕 宽度、高度
#define SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

#define WIDTHBASE      ([UIScreen mainScreen].bounds.size.width/375)    //适配6
#define HEIGHTBASE     ([UIScreen mainScreen].bounds.size.height/668)

//rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:\
((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define RGBCOLOR(r,g,b,a)           [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f\
blue:(b)/255.f\
alpha:(a)]

//log
#ifdef DEBUG

#define DLog(format, ...) printf("class:%s [Line %d] ==========================================================================================\n%s\n\
=================================================================================================================================================\n",\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])

#else

#define DLog(format, ...)

#endif
