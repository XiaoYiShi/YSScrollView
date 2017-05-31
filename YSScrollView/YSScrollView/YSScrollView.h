//
//  YSScrollView.h
//  YSScrollView
//
//  Created by 史晓义 on 2017/5/31.
//  Copyright © 2017年 史晓义. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSScrollViewDelegate <NSObject>

@optional
- (void)YSScrollViewTouchIndex:(NSInteger)index;

@end

@interface YSScrollView : UIView

@property (strong,  nonatomic) NSString *placeImageName;            //占位图
@property (weak,    nonatomic) id <YSScrollViewDelegate> delegate;  //代理
@property (strong,  nonatomic) NSArray <NSString *> *imageURLArray; //图片地址数组


- (void)timerOff;
- (void)timerOn;

@end










