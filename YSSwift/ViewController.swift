//
//  ViewController.swift
//  YSSwift
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//

import UIKit

class ViewController: UIViewController, YSScrollViewDelegate {
    
    var banner : YSScrollView? = nil //轮播图
    
    let imageUrlStringArray = ["http://imgsrc.baidu.com/forum/pic/item/d097f603738da97772b89243b251f8198718e3ce.jpg",
                               "http://imgsrc.baidu.com/forum/w%3D580/sign=a49682b40afa513d51aa6cd60d6d554c/18055aafa40f4bfbcef4893c014f78f0f73618bc.jpg",
                               "http://imgsrc.baidu.com/forum/w%3D580/sign=012250d34510b912bfc1f6f6f3fcfcb5/4f658535e5dde7115cdc549ea5efce1b9d166157.jpg",
                               "http://imgsrc.baidu.com/forum/w%3D580/sign=56ae691222a446237ecaa56aa8237246/e3360a55b319ebc48cc965f18026cffc1e17162f.jpg",
                               "http://imgsrc.baidu.com/forum/w%3D580/sign=3290b51dd488d43ff0a991fa4d1fd2aa/541c9d16fdfaaf513d4d93d78e5494eef01f7a37.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        self.banner = YSScrollView.init(frame: CGRect.init(x: 0, y: 20, width: SCREEN_WIDTH, height: 270*WIDTHBASE))
        self.banner?.delegate = self
        self.banner?.backgroundColor = UIColorFromRGB(0xf5f5f5)
        self.view.addSubview(self.banner!)
        
        self.banner?.placeImageName = "img_sara"
        self.banner?.imageURLArray = self.imageUrlStringArray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //进入VC把timer开启
        self.banner?.timerOn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //离开VC把timer关闭，节约内存
        self.banner?.timerOff()
    }
    
    //YSScrollViewDelegate操作返回
    func YSScrollViewTouch(index: NSInteger) {
        if index < self.imageUrlStringArray.count {
            print("这张题片下标是\(index)")
        }
    }
    
}

