//
//  CHSTabBarView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSTabBarView: UITabBar {


    //将每个按钮的位置移动,空出中间的位置,添加一个按钮
    override init(frame: CGRect) {
        //移动位置
        super.init(frame: frame)
      
        addSubview(composeBtn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var index: CGFloat = 0
        
        for subView in subviews {
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
 
                
                let w = UIScreen.mainScreen().bounds.width / 5
                let h = self.bounds.height
                //如果遇到第二个,空个位置出来
                if index == 2 {
                    composeBtn.frame = CGRectMake(index * w, 0, w, h)
                    index++
                }
                
                subView.frame = CGRectMake(index * w, 0, w, h)
                index++
//                print(subView)
            }
        }
    }
    
    @objc private func composeBtnClicking() {
        print("加号按钮被点击了")
    }
    
    
    lazy var composeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: .Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: .Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: .Highlighted)
        //添加点击事件
        btn.addTarget(self, action: "composeBtnClicking", forControlEvents: .TouchUpInside)
        
        
        return btn
    }()
    

}
