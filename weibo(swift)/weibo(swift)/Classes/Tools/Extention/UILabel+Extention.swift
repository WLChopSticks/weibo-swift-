//
//  UILabel+Extention.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/16.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

//构造便利函数,扩展label的方法
extension UILabel {
    
    convenience init(title: String, color: UIColor, fontSize: CGFloat, margin: CGFloat = 0) {
        self.init()
        text = title
        numberOfLines = 0
        textColor = color
        textAlignment = .Center
        font = UIFont.systemFontOfSize(fontSize)
        //针对参数设置label的宽度
        if margin != 0 {
            preferredMaxLayoutWidth = screenWidth - 2 * margin
            textAlignment = .Left
        }
        
    }
    

}