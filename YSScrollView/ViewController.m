//
//  ViewController.m
//  YSScrollView
//
//  Created by 史晓义 on 2017/5/31.
//  Copyright © 2017年 史晓义. All rights reserved.
//


#import "ViewController.h"

#import "YSScrollView.h"
#import "Header.h"

@interface ViewController () <YSScrollViewDelegate>

@property (strong, nonatomic) YSScrollView *banner;//轮播图
@property (strong, nonatomic) NSArray *imageUrlStringArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.banner];
    self.banner.placeImageName = @"img_sara";
    self.banner.imageURLArray = self.imageUrlStringArray;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_banner timerOn];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //离开viewcontroller把timer关闭，节约内存
    [_banner timerOff];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - init
- (NSArray *)imageUrlStringArray {
    if (!_imageUrlStringArray) {
        _imageUrlStringArray = [NSArray arrayWithObjects:
                                @"http://imgsrc.baidu.com/forum/pic/item/d097f603738da97772b89243b251f8198718e3ce.jpg",
                                @"http://imgsrc.baidu.com/forum/w%3D580/sign=a49682b40afa513d51aa6cd60d6d554c/18055aafa40f4bfbcef4893c014f78f0f73618bc.jpg",
                                @"http://imgsrc.baidu.com/forum/w%3D580/sign=012250d34510b912bfc1f6f6f3fcfcb5/4f658535e5dde7115cdc549ea5efce1b9d166157.jpg",
                                @"http://imgsrc.baidu.com/forum/w%3D580/sign=56ae691222a446237ecaa56aa8237246/e3360a55b319ebc48cc965f18026cffc1e17162f.jpg",
                                @"http://imgsrc.baidu.com/forum/w%3D580/sign=3290b51dd488d43ff0a991fa4d1fd2aa/541c9d16fdfaaf513d4d93d78e5494eef01f7a37.jpg",
                                nil];
    }
    return _imageUrlStringArray;
}

- (YSScrollView *)banner {
    if (!_banner) {
        _banner = [[YSScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 270*WIDTHBASE)];
        _banner.delegate = self;
        _banner.backgroundColor = UIColorFromRGB(0xf5f5f5);
    }
    return _banner;
}

#pragma mark - YSScrollViewDelegate
- (void)YSScrollViewTouchIndex:(NSInteger)index
{
    if (index<_imageUrlStringArray.count) {
        DLog(@"这张题片下标是%ld",(long)index);
    }
}

@end







