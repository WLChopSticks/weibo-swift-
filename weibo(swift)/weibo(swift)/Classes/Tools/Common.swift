//
//  Common.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit



//app基本信息
let client_id = "3754893333"
let client_secret = "d0f495da519ae1132e38b48084ce3fb9"
let redirect_uri = "http://www.baidu.com"

//定义系统的主色调
let themeColor = UIColor.orangeColor()

//定义切换控制器的通知名称
let changeRootViewController = "changeRootViewController"

//定义屏幕的宽度
let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height

//定义微博状态cell的间距
let statusCellMargin: CGFloat = 10

//随机颜色
func randomColor() -> UIColor {
    let r = CGFloat((random() % 256)) / 255.0
    let g = CGFloat((random() % 256)) / 255.0
    let b = CGFloat((random() % 256)) / 255.0
    return UIColor(red: r, green: g, blue: b, alpha: 1)
}