//
//  UIView+YS.h
//  YSOC
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YS)

@property (assign, nonatomic) CGFloat ys_x;        //x坐标
@property (assign, nonatomic) CGFloat ys_y;        //y坐标
@property (assign, nonatomic) CGFloat ys_width;    //宽
@property (assign, nonatomic) CGFloat ys_height;   //高
@property (assign, nonatomic) CGFloat ys_right;    //右边
@property (assign, nonatomic) CGFloat ys_bottom;   //下边
@property (assign, nonatomic) CGSize  ys_size;     //尺寸：宽和高
@property (assign, nonatomic) CGPoint ys_origin;   //坐标：x和y

/**
 快速设置view常用layer参数
 
 @param radius 圆角
 @param wdith 边框    不设置边框就传0
 @param color 边框颜色 可不传
 */
- (void)layerWithCornerRadius:(CGFloat)radius BorderWidth:(CGFloat)wdith BorderColor:(UIColor *)color;


@end

