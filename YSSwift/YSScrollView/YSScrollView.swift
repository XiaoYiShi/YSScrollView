//
//  YSScrollView.swift
//  YSSwift
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//

import UIKit

protocol YSScrollViewDelegate : NSObjectProtocol {
    //点击图片以代理返回
    func YSScrollViewTouch(index:NSInteger) -> Void
}


class YSScrollView: UIView ,UIScrollViewDelegate {
    
    var placeImageName = ""                     //占位图片名
    weak var delegate : YSScrollViewDelegate?   //代理
    var imageURLArray = [String]()              //图片地址数组
    {
        didSet {
            self.timerOff()
            
            self.pageControl.isHidden = true
            if self.imageURLArray.count == 0 {
                return
            }
            
            self.pageControl.isHidden = false
            self.scrollView.contentSize = CGSize.init(width: self.ys_width*CGFloat(self.imageURLArray.count+2),
                                                      height: self.ys_height)
            self.scrollView.contentOffset = CGPoint.init(x: self.ys_width,
                                                         y: 0)
            
            //只有一张时不允许滚动
            if self.imageURLArray.count == 1 {
                self.pageControl.numberOfPages = 0
                self.scrollView.isUserInteractionEnabled = false
                self.setScrollViewShowImage(index: 0)
            } else {
                self.pageControl.numberOfPages = self.imageURLArray.count
                self.scrollView.isUserInteractionEnabled = true
                self.setScrollViewShowImage(index: 0)
                
                self.timerOn()
            }
        }
    }
    
    public  var timerIntrval = 3.5                      //timer的计时时间
    private let pageControl = UIPageControl.init()      //页标记
    private let scrollView  = UIScrollView.init()       //滚动视图
    
    private var timer : Timer? = nil                    //计时器
    private var imageViewArray = [UIImageView]()        //存ImageView的数组
    private var scrollPage = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        
        //创建点击手势
        let tapGR = UITapGestureRecognizer.init(target: self,
                                                action: #selector(tapGRSEL))
        self.addGestureRecognizer(tapGR)
        
        self.scrollView.frame = CGRect.init(x: 0,
                                            y: 0,
                                            width: self.ys_width,
                                            height: self.ys_height)
        self.scrollView.showsHorizontalScrollIndicator = false //隐藏滚动条
        self.scrollView.scrollsToTop    = false     //关闭scrollsToTop，不会影响控制器的scrollsToTop属性
        self.scrollView.delegate        = self
        self.scrollView.backgroundColor = UIColor.clear
        self.scrollView.isPagingEnabled = true      //开启分页
        //添加三张图
        for _ in 0..<3 {
            let imageview = UIImageView.init()
            imageview.contentMode = .scaleAspectFit
            self.scrollView.addSubview(imageview)
            self.imageViewArray.append(imageview)
        }
        self.addSubview(self.scrollView)
        
        self.pageControl.frame = CGRect.init(x: 0,
                                             y: self.ys_height-20,
                                             width: self.ys_width,
                                             height: 20)
        self.pageControl.isUserInteractionEnabled = false
        self.addSubview(self.pageControl)
        self.pageControl.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            self.layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.ys_size = CGSize.init(width: self.ys_width,
                                         height: self.ys_height)
        if self.bounds.size.height >= 20 {
            pageControl.frame = CGRect.init(x: 0,
                                            y: self.ys_height-20,
                                            width: self.ys_width,
                                            height: 20)
        } else {
            pageControl.frame = CGRect.init(x: 0,
                                            y: 0,
                                            width: self.ys_width,
                                            height: 0)
        }
        for imageV in self.imageViewArray {
            imageV.ys_width     = self.ys_width
            imageV.ys_height    = self.ys_height
        }
    }
    
    
    // scrollViewDelegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timerOff()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var point = scrollView.contentOffset
        
        if point.x >= scrollView.ys_width*CGFloat(self.imageURLArray.count+1) {
            point.x = scrollView.ys_width
            
        } else if point.x <= 0 {
            point.x = scrollView.ys_width*CGFloat(self.imageURLArray.count)
        }
        
        let page = Int(point.x/scrollView.ys_width-1)
        
        if page == self.scrollPage {
            
        } else {
            self.scrollPage = page
            scrollView.contentOffset = point
            
            self.setScrollViewShowImage(index: page)
        }
    }
    
    
    //滚动视图滑动结束
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.timerOn()
    }
    
    
    //  SEL
    @objc private func tapGRSEL() -> Void {
        let i = Int(self.scrollView.contentOffset.x/self.scrollView.ys_width)
        
        if self.imageURLArray.count > 0 {
            //代理传值，在外部响应
            self.delegate?.YSScrollViewTouch(index: i-1)
        }
    }
    
    
    //计时器触发函数
    @objc private func timerFired() -> Void {
        
        if self.imageURLArray.count == 0 {
            return
        }
        
        var point = self.scrollView.contentOffset
        self.scrollPage += 1
        point.x = self.ys_width*CGFloat(self.scrollPage+1)
        
        self.scrollView.setContentOffset(point, animated: true)
    }
    
    
    // timer
    //离开viewcontroller把timer关闭，节约内存
    
    //关闭定时器
    func timerOff() -> Void {
        timer?.invalidate()
        timer = nil
    }
    //开启定时器
    func timerOn() -> Void {
        self.timerOff()
        
        if self.timer != nil {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: self.timerIntrval,
                                     target: self,
                                     selector: #selector(timerFired),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.current.add(self.timer!, forMode: .defaultRunLoopMode)
    }
    
    
    //  设置当前展示图片
    private func setScrollViewShowImage(index:Int) -> Void {
        for i in 0..<3 {
            self.imageViewArray[i].frame = CGRect.init(x: self.ys_width*CGFloat(index+i),
                                                       y: 0,
                                                       width: self.ys_width,
                                                       height: self.ys_height)
            var imageUrlStr = String()
            
            if index+i == 0 {
                imageUrlStr = self.imageURLArray.last!
            } else if index+i == self.imageURLArray.count+1 {
                imageUrlStr = self.imageURLArray.first!
            } else {
                imageUrlStr = self.imageURLArray[index+i-1]
            }
            
            self.imageViewArray[i].sd_setImage(with: URL.init(string: imageUrlStr),
                                               placeholderImage: UIImage.init(named:
                                                self.placeImageName))
        }
        self.pageControl.currentPage = index
    }
    
}







