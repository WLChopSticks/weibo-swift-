//
//  CHSBaseViewController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSBaseViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //在此判断是否进入访客视图,还是直接进入home界面
        let userLogIn = false
        
        if userLogIn {
            //进入home页面
            print("登陆成功")
        }else {
            let guestView = CHSGuestView()
            view = guestView
            
            
            
        }
        
    }

    
    
    
}
