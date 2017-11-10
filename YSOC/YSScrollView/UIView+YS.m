//
//  UIView+YS.m
//  YSOC
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//

#import "UIView+YS.h"

@implementation UIView (YS)


//-------------------------------------- x --------------------------------------------
- (void)setYs_x:(CGFloat)ys_x
{
    CGRect frame = self.frame;
    frame.origin.x = ys_x;
    self.frame = frame;
}

- (CGFloat)ys_x
{
    return self.frame.origin.x;
}
//-------------------------------------- x --------------------------------------------


//-------------------------------------- y --------------------------------------------

- (void)setYs_y:(CGFloat)ys_y
{
    CGRect frame = self.frame;
    frame.origin.y = ys_y;
    self.frame = frame;
}

- (CGFloat)ys_y
{
    return self.frame.origin.y;
}
//-------------------------------------- y --------------------------------------------


//------------------------------------ width ------------------------------------------

- (void)setYs_width:(CGFloat)ys_width
{
    CGRect frame = self.frame;
    frame.size.width = ys_width;
    self.frame = frame;
}

- (CGFloat)ys_width
{
    return self.frame.size.width;
}
//------------------------------------ width ------------------------------------------


//----------------------------------- height ------------------------------------------

- (void)setYs_height:(CGFloat)ys_height
{
    CGRect frame = self.frame;
    frame.size.height = ys_height;
    self.frame = frame;
}

- (CGFloat)ys_height
{
    return self.frame.size.height;
}
//----------------------------------- height ------------------------------------------


//------------------------------------ right ------------------------------------------

- (void)setYs_right:(CGFloat)ys_right
{
    CGRect frame = self.frame;
    frame.origin.x = ys_right-frame.size.width;
    self.frame = frame;
}

- (CGFloat)ys_right
{
    return self.frame.size.width+self.frame.origin.x;
}
//------------------------------------ right ------------------------------------------


//----------------------------------- bottom ------------------------------------------

- (void)setYs_bottom:(CGFloat)ys_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = ys_bottom-frame.size.height;
    self.frame = frame;
}

- (CGFloat)ys_bottom
{
    return self.frame.size.height+self.frame.origin.y;
}
//----------------------------------- bottom ------------------------------------------


//------------------------------------ size -------------------------------------------

- (void)setYs_size:(CGSize)ys_size
{
    CGRect frame = self.frame;
    frame.size = ys_size;
    self.frame = frame;
}

- (CGSize)ys_size
{
    return self.frame.size;
}
//------------------------------------ size -------------------------------------------


//----------------------------------- origin ------------------------------------------

- (void)setYs_origin:(CGPoint)ys_origin
{
    CGRect frame = self.frame;
    frame.origin = ys_origin;
    self.frame = frame;
}

- (CGPoint)ys_origin
{
    return self.frame.origin;
}

//----------------------------------- origin ------------------------------------------

- (void)layerWithCornerRadius:(CGFloat)radius BorderWidth:(CGFloat)wdith BorderColor:(UIColor *)color {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = wdith;
    if (color) {
        self.layer.borderColor = color.CGColor;
    }
}



@end





