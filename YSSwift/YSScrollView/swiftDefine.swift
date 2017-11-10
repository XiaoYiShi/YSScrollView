//
//  swiftDefine.swift
//  YSSwift
//
//  Created by 史晓义 on 2017/11/10.
//  Copyright © 2017年 懒人. All rights reserved.
//

import UIKit




//----------------------获取设备屏幕大小------------------
//获取屏幕 宽度、高度
let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

/**
 适配6
 */
let WIDTHBASE  = (SCREEN_WIDTH/375)
let HEIGHTBASE = (SCREEN_HEIGHT/668)


//-----------------------获取设备屏幕大小-------------------


//-------------------系统------------

//获取系统版本
let CurrentSystemVersion = UIDevice.current.systemVersion

//获取当前语言
let CurrentLanguage = Locale.preferredLanguages[0]

//判断设备的操做系统是不是ios8
let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0

//-------------------系统------------



//---------------颜色类----------------

// rgb颜色转换（16进制->10进制）
func UIColorFromRGB(_ rgbValue:UInt) -> UIColor
{
    return UIColor(red:   CGFloat((rgbValue & 0xFF0000) >> 16)/255.0,
                   green: CGFloat((rgbValue & 0x00FF00) >> 8)/255.0,
                   blue:  CGFloat( rgbValue & 0x0000FF)/255.0,
                   alpha: 1.0)
}
//带有RGBA的颜色设置
func RGBA(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor
{
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//---------------颜色类----------------




