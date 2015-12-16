//
//  CHSOauthController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/16.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSOauthController: UIViewController {

    
    let web = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将View替换成webView 用来显示登陆页面
        view = web
        
        //添加左右两侧的返回和自动填写按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .Plain, target: self, action: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "自动填写", style: .Plain, target: self, action: "")
        
        
    }

    //将modal出的控制器清除
    private func returnMain() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //自动填写的实现方法
    private func autoFill() {
        let jscommand = "document.getElementById('userId').value = '18602602808' ,document.getElementById('passwd').value = '1357924680'"
        web.stringByEvaluatingJavaScriptFromString(jscommand)
    }


}
