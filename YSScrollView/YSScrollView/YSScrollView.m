//
//  YSScrollView.m
//  YSScrollView
//
//  Created by 史晓义 on 2017/5/31.
//  Copyright © 2017年 史晓义. All rights reserved.
//

#import "YSScrollView.h"

#import "UIImageView+WebCache.h"

@interface YSScrollView () <UIScrollViewDelegate>

@property (strong, nonatomic) UIPageControl      *pageControl;        //页标记
@property (strong, nonatomic) UIScrollView       *scrollView;         //滚动视图

@property (retain, nonatomic) NSTimer            *timer;              //计时器
@property (assign, nonatomic) CGFloat            timerIntrval;        //timer的计时时间

@property (strong, nonatomic) NSArray<UIImageView *> *imageViewArray; //存图片控件的数组

@end


@implementation YSScrollView

//----------------------------------------------------init---------------------------------------------------------------------
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor     = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        _timerIntrval = 3.5f;
        
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
    _scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    if (self.bounds.size.height>20) {
        _pageControl.frame = CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20);
    } else {
        _pageControl.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _scrollView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    if (self.bounds.size.height>20) {
        _pageControl.frame = CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20);
    } else {
        _pageControl.frame = CGRectMake(0, 0, self.bounds.size.width, 0);
    }
}

//scrollView对应图片的点击事件
- (void)tapGR {
    int i = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    if (_imageURLArray.count>0) {
        //代理传值，在外部响应
        [self.delegate YSScrollViewTouchIndex:i-1];
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
        _pageControl.userInteractionEnabled = YES;
    }
    return _pageControl;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scrollView.showsHorizontalScrollIndicator = NO;//隐藏滚动条
        _scrollView.scrollsToTop           = NO;  //关闭scrollsToTop，不会影响控制器的scrollsToTop属性
        _scrollView.delegate               = self;
        _scrollView.backgroundColor        = [UIColor clearColor];
        _scrollView.pagingEnabled          = YES; //开启分页
        
        UIImageView *image1 = [[UIImageView alloc] init];
        image1.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:image1];
        UIImageView *image2 = [[UIImageView alloc] init];
        image2.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:image2];
        UIImageView *image3 = [[UIImageView alloc] init];
        image3.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:image3];
        
        _imageViewArray = @[image1, image2, image3];
    }
    return _scrollView;
}
//----------------------------------------------------init---------------------------------------------------------------------



//----------------------------------------------------delegate---------------------------------------------------------------------
//开始拖拽，要关闭计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self timerOff];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = _scrollView.contentOffset;
    if (point.x > (_scrollView.frame.size.width)*(_imageURLArray.count+1)) {
        point.x = _scrollView.frame.size.width;
        _scrollView.contentOffset = point;
        CGFloat xmove = _scrollView.frame.size.width;
        [self setScrollViewShowImageIndex:xmove/_scrollView.bounds.size.width-1];
    }else if (point.x <= 0){
        point.x = _scrollView.frame.size.width*(_imageURLArray.count);
        _scrollView.contentOffset = point;
        CGFloat xmove = _scrollView.frame.size.width*(_imageURLArray.count);
        [self setScrollViewShowImageIndex:xmove/_scrollView.bounds.size.width-1];
    }
}

//滚动视图滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    if (point.x == _scrollView.frame.size.width*(self.imageURLArray.count+1)) {
        point.x = _scrollView.frame.size.width;
    }else if (point.x == 0){
        point.x = _scrollView.frame.size.width*self.imageURLArray.count;
    }
    scrollView.contentOffset = point;
    //x方向移动的距离
    CGFloat xmove = _scrollView.contentOffset.x;
    [self setScrollViewShowImageIndex:xmove/_scrollView.bounds.size.width-1];
    [self timerOn];
}

//----------------------------------------------------delegate---------------------------------------------------------------------



//----------------------------------------------------timer---------------------------------------------------------------------
//关闭定时器
-(void)timerOff {
    [_timer invalidate];
    _timer = nil;
}

//开启定时器
-(void)timerOn{
    [self timerOff];
    if(_timer != nil) return;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timerIntrval target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

//计时器触发函数
- (void)timerFired{
    if (!self.imageURLArray.count) return;
    
    if (self.imageURLArray.count == 1) {
        self.pageControl.hidden = YES;
        return;
    } else {
        self.pageControl.hidden = NO;
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = _scrollView.contentOffset;
        point.x += _scrollView.bounds.size.width;
        _scrollView.contentOffset = point;
    } completion:^(BOOL finished) {
        CGPoint point = _scrollView.contentOffset;
        if (point.x == _scrollView.bounds.size.width*(_imageURLArray.count+1)) {
            point.x = _scrollView.bounds.size.width;
        }
        _scrollView.contentOffset = point;
        [self setScrollViewShowImageIndex:point.x/_scrollView.bounds.size.width-1];
    }];
}

//----------------------------------------------------timer---------------------------------------------------------------------


#pragma mark - 刷新scrollview
- (void)setScrollViewShowImageIndex:(NSInteger)index {
    
    for (int i = 0; i<3; i++) {
        UIImageView *imageView = _imageViewArray[i];
        imageView.frame = CGRectMake(self.frame.size.width*(index+i), 0, self.frame.size.width, self.bounds.size.height);
        if (index+i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageURLArray.lastObject] placeholderImage:[UIImage imageNamed:_placeImageName]];
        }else if(index+i == _imageURLArray.count+1){
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageURLArray.firstObject] placeholderImage:[UIImage imageNamed:_placeImageName]];
        }else{
            [imageView sd_setImageWithURL:[NSURL URLWithString:[_imageURLArray objectAtIndex:index+i-1]]
                         placeholderImage:[UIImage imageNamed:_placeImageName]];
        }
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
    
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width*(_imageURLArray.count+2), self.bounds.size.height);
    _scrollView.contentOffset   = CGPointMake(self.bounds.size.width, 0);
    _pageControl.numberOfPages  = _imageURLArray.count;
    [self setScrollViewShowImageIndex:0];
    [self timerOn];
}


@end
