//
//  CHSBaseViewController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSBaseViewController: UITableViewController, guestViewDelegate {
    
    //设置一个全局变量,让外界控制器通过调用它实现页面的变换
    var guestView: CHSGuestView?

    override func viewDidLoad() {
        super.viewDidLoad()

        //在此判断是否进入访客视图,还是直接进入home界面
        let userLogIn = false
        
        if userLogIn {
            //进入home页面
            print("登陆成功")
        }else {
            //初始化View  否则什么都不会显示
            guestView = CHSGuestView()
            view = guestView
            
            //设置代理
            guestView?.delegate = self
        }
        
        logInAndRegistButton()
        
    }
    
    
    private func logInAndRegistButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "登陆", style: .Plain, target: self, action: "logInButtonClicking")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: .Plain, target: self, action: "registButtonClicking")
    }
    
    //按钮的点击事件
    @objc func registButtonClicking() {
        print("注册按钮被点击了")
    }
    
    @objc func logInButtonClicking() {
//        print("登陆安妮被点击了")
        //在此modal一个登陆页面
        let logInVC = CHSOauthController()
        let navVC = CHSNavController(rootViewController: logInVC)
        
        presentViewController(navVC, animated: true, completion: nil)
    }

    
    
    
}
