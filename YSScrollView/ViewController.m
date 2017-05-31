//
//  ViewController.m
//  YSScrollView
//
//  Created by 史晓义 on 2017/5/31.
//  Copyright © 2017年 史晓义. All rights reserved.
//

/**
 获取屏幕 宽度、高度
 */
#define SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

/**
 适配6
 */
#define WIDTHBASE      ([UIScreen mainScreen].bounds.size.width/375)
#define HEIGHTBASE     ([UIScreen mainScreen].bounds.size.height/668)

/**
 rgb颜色转换（16进制->10进制）
 */
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:\
                                    ((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                    blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 带有RGBA的颜色设置
 */
#define RGBCOLOR(r,g,b,a)           [UIColor colorWithRed:(r)/255.f \
                                    green:(g)/255.f\
                                    blue:(b)/255.f\
                                    alpha:(a)]

#ifdef DEBUG

#define DLog(format, ...) printf("class:%s [Line %d] ==========================================================================================\n%s\n\
=================================================================================================================================================\n",\
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])

#else

#define DLog(format, ...)

#endif


#import "ViewController.h"
#import "YSScrollView.h"

@interface ViewController () <YSScrollViewDelegate>

@property (strong, nonatomic) YSScrollView *banner;//轮播图
@property (strong, nonatomic) NSArray *imageUrlStringArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.banner];
    
    _banner.placeImageName = @"img_sara";
    _imageUrlStringArray = [NSArray arrayWithObjects:
                            @"http://imgsrc.baidu.com/forum/pic/item/d097f603738da97772b89243b251f8198718e3ce.jpg",
                            @"http://imgsrc.baidu.com/forum/w%3D580/sign=a49682b40afa513d51aa6cd60d6d554c/18055aafa40f4bfbcef4893c014f78f0f73618bc.jpg",
                            @"http://imgsrc.baidu.com/forum/w%3D580/sign=012250d34510b912bfc1f6f6f3fcfcb5/4f658535e5dde7115cdc549ea5efce1b9d166157.jpg",
                            @"http://imgsrc.baidu.com/forum/w%3D580/sign=56ae691222a446237ecaa56aa8237246/e3360a55b319ebc48cc965f18026cffc1e17162f.jpg",
                            @"http://imgsrc.baidu.com/forum/w%3D580/sign=3290b51dd488d43ff0a991fa4d1fd2aa/541c9d16fdfaaf513d4d93d78e5494eef01f7a37.jpg",
                            nil];
    _banner.imageURLArray = _imageUrlStringArray;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_banner timerOn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_banner timerOff];
}

- (YSScrollView *)banner {
    if (!_banner) {
        _banner = [[YSScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 270*WIDTHBASE)];
        _banner.delegate = self;
        _banner.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _banner;
}

//轮播图代理
- (void)YSScrollViewTouchIndex:(NSInteger)index
{
    if (index<_imageUrlStringArray.count) {
        DLog(@"选择了下标第%ld张",(long)index);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
