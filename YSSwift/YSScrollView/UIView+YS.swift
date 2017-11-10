//
//  UIView+YS.swift
//  YSSwift
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var ys_x : CGFloat //x坐标
    {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var ys_y : CGFloat { //y坐标
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var ys_width : CGFloat { //宽
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var ys_height : CGFloat { //高
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var ys_right : CGFloat { //右边
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            return self.frame.size.width+self.frame.origin.x
        }
    }
    
    var ys_bottom : CGFloat { //下边
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.frame.size.height+self.frame.origin.y
        }
    }
    
    var ys_size : CGSize { //尺寸：宽和高
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var ys_origin : CGPoint { //坐标：x和y
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    /// 快速设置view常用layer参数
    ///
    /// - Parameters:
    ///   - radius: 圆角
    ///   - wdith: 边框    不设置边框就传0
    ///   - color: 边框颜色 可不传
    func layerWith(radius:CGFloat ,wdith:CGFloat ,color:UIColor ) -> Void {
        self.layer.masksToBounds    = true
        self.layer.cornerRadius     = radius
        self.layer.borderWidth      = wdith
        self.layer.borderColor      = color.cgColor
    }
    
}





