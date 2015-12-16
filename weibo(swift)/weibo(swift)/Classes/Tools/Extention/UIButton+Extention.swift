//
//  UIButton+Extention.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/16.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit


extension UIButton {

    //初始化按钮的方法,由文字和背景图片组成
    convenience init(title: String, titleColor: UIColor, backImage: String) {
        self.init()
        
        setTitle(title, forState: .Normal)
        setTitleColor(titleColor, forState: .Normal)
        print(backImage)
        let btnImage2 = UIImage(named: backImage)
        let btnImage = btnImage2?.resizableImageWithCapInsets(UIEdgeInsetsMake((btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5, (btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5))
        setBackgroundImage(btnImage, forState: .Normal)

    }
    
    //初始化按钮的方法,没有文字,由图片和背景图片组成
    convenience init(image: String,imageHighlight: String, backImage: String, backImageHighlight: String) {
        self.init()
        
        setImage(UIImage(named: image), forState: .Normal)
        setImage(UIImage(named: imageHighlight), forState: .Highlighted)
        setBackgroundImage(UIImage(named: backImage), forState: .Normal)
        setBackgroundImage(UIImage(named: backImageHighlight), forState: .Highlighted)
        
    }





}