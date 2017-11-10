//
//  YSScrollView.h
//  YSOC
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol YSScrollViewDelegate <NSObject>

@optional
//点击图片以代理返回
- (void)YSScrollViewTouchIndex:(NSInteger)index;

@end


@interface YSScrollView : UIView

@property (strong,  nonatomic) NSString *placeImageName;            //占位图片名
@property (weak,    nonatomic) id <YSScrollViewDelegate> delegate;  //代理
@property (strong,  nonatomic) NSArray <NSString *> *imageURLArray; //图片地址数组

//离开viewcontroller把timer关闭，节约内存
- (void)timerOff;
- (void)timerOn;

@end






