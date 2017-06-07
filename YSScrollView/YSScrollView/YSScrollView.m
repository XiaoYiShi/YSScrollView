//
//  YSScrollView.m
//  YSScrollView
//
//  Created by 史晓义 on 2017/5/31.
//  Copyright © 2017年 史晓义. All rights reserved.
//

#import "YSScrollView.h"

#import "UIImageView+WebCache.h"
#import "UIView+YS.h"

#define timerIntrval 3.5f //timer的计时时间


@interface YSScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl      *pageControl;        //页标记
@property (strong, nonatomic) UIScrollView       *scrollView;         //滚动视图
@property (retain, nonatomic) NSTimer            *timer;              //计时器

@property (strong, nonatomic) NSArray<UIImageView *> *imageViewArray; //存ImageView的数组

@property (assign, nonatomic) NSInteger scrollPage;

@end


@implementation YSScrollView

#pragma mark - init

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor     = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        _scrollPage = 0;
        
        //创建点击手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGR)];
        [self addGestureRecognizer:tapGR];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        self.pageControl.hidden = YES;
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.ys_size = CGSizeMake(self.ys_width, self.ys_height);
    if (self.bounds.size.height >= 20) {
        _pageControl.frame = CGRectMake(0, self.ys_height-20, self.ys_width, 20);
    } else {
        _pageControl.frame = CGRectMake(0, 0, self.ys_width, 0);
    }
    if (self.imageViewArray.count == 3 ) {
        self.imageViewArray[0].ys_width     = self.ys_width;
        self.imageViewArray[0].ys_height    = self.ys_height;
        self.imageViewArray[1].ys_width     = self.ys_width;
        self.imageViewArray[1].ys_height    = self.ys_height;
        self.imageViewArray[2].ys_width     = self.ys_width;
        self.imageViewArray[2].ys_height    = self.ys_height;
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.ys_height-20, self.ys_width, 20)];
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.ys_width, self.ys_height)];
        _scrollView.showsHorizontalScrollIndicator = NO;//隐藏滚动条
        _scrollView.scrollsToTop           = NO;        //关闭scrollsToTop，不会影响控制器的scrollsToTop属性
        _scrollView.delegate               = self;
        _scrollView.backgroundColor        = [UIColor clearColor];
        _scrollView.pagingEnabled          = YES;       //开启分页
        
        //添加三张图
        NSMutableArray *imageArr = [NSMutableArray array];
        for (int i = 0; i<3; i++) {
            UIImageView *image1 = [UIImageView new];
            image1.contentMode = UIViewContentModeScaleAspectFit;
            [_scrollView addSubview:image1];
            [imageArr addObject:image1];
        }
        
        _imageViewArray = imageArr;
    }
    return _scrollView;
}


#pragma scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self timerOff];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGPoint point = _scrollView.contentOffset;
    
    if (point.x >= _scrollView.ys_width*(_imageURLArray.count+1)) {
        point.x = _scrollView.ys_width;
    } else if (point.x <= 0){
        point.x = _scrollView.ys_width*_imageURLArray.count;
    }
    
    NSInteger page = point.x/_scrollView.ys_width-1;
    if (page == _scrollPage) {
        
    } else {
        _scrollPage = page;
        _scrollView.contentOffset = point;
        
        [self setScrollViewShowImageIndex:page];
    }
    
}

//滚动视图滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self timerOn];
}

#pragma mark - SEL
- (void)tapGR {
    int i = _scrollView.contentOffset.x/_scrollView.ys_width;
    if (_imageURLArray.count>0) {
        //代理传值，在外部响应
        [self.delegate YSScrollViewTouchIndex:i-1];
    }
}

//计时器触发函数
- (void)timerFired {
    
    if (!self.imageURLArray.count) return;
    
    CGPoint point = self.scrollView.contentOffset;
    self.scrollPage += 1;
    point.x = self.ys_width*(self.scrollPage+1);
    
    [_scrollView setContentOffset:point animated:YES];
}

#pragma mark - timer
//关闭定时器
-(void)timerOff {
    [_timer invalidate];
    _timer = nil;
}

//开启定时器
-(void)timerOn
{
    [self timerOff];
    if(_timer != nil) return;
    _timer = [NSTimer scheduledTimerWithTimeInterval:timerIntrval
                                              target:self
                                            selector:@selector(timerFired)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}



#pragma mark - set
- (void)setScrollViewShowImageIndex:(NSInteger)index {
    
    for (int i = 0; i<3; i++) {
        
        _imageViewArray[i].frame = CGRectMake(self.ys_width*(index+i), 0, self.ys_width, self.ys_height);
        
        NSString *imageUrlStr = nil;
        if (index+i == 0) {
            imageUrlStr = _imageURLArray.lastObject;
        } else if(index+i == _imageURLArray.count+1){
            imageUrlStr = _imageURLArray.firstObject;
        } else {
            imageUrlStr = [_imageURLArray objectAtIndex:index+i-1];
        }
        
        [_imageViewArray[i] sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]
                              placeholderImage:[UIImage imageNamed:_placeImageName]];
    }
    _pageControl.currentPage = index;
}


- (void)setImageURLArray:(NSArray<NSString *> *)imageURLArray
{
    
    [self timerOff];
    
    self.pageControl.hidden = YES;
    _imageURLArray = imageURLArray;
    
    if (!_imageURLArray.count) return;
    
    self.pageControl.hidden = NO;
    
    self.scrollView.contentSize = CGSizeMake(self.ys_width*(_imageURLArray.count+2), self.ys_height);
    _scrollView.contentOffset   = CGPointMake(self.ys_width, 0);
    
    //只有一张时不允许滚动
    if (_imageURLArray.count == 1) {
        
        _pageControl.numberOfPages  = 0;
        _scrollView.userInteractionEnabled = NO;
        [self setScrollViewShowImageIndex:0];
        
    } else {
        
        _pageControl.numberOfPages  = _imageURLArray.count;
        _scrollView.userInteractionEnabled = YES;
        [self setScrollViewShowImageIndex:0];
        
        [self timerOn];
    }
}

@end









