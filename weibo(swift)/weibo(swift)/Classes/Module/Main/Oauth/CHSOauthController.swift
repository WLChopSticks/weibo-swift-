//
//  CHSOauthController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/16.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import AFNetworking

class CHSOauthController: UIViewController {

    
    let web = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将View替换成webView 用来显示登陆页面
        view = web
        
        //添加左右两侧的返回和自动填写按钮
        addreturnBtnAndAutoFillBtn()
        
        //加载登陆页面
        let logInURL = NSURL(string: "https://api.weibo.com/oauth2/authorize?client_id=3754893333&redirect_uri=http://www.baidu.com")!
        let request = NSURLRequest(URL: logInURL)
        web.loadRequest(request)
        
        
    }
    
    //添加所有两侧的返回和自动填写按钮
    private func addreturnBtnAndAutoFillBtn() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .Plain, target: self, action: "returnMain")
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "自动填写", style: .Plain, target: self, action: "autoFill")
    }

    //将modal出的控制器清除
    @objc private func returnMain() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //自动填写的实现方法
    @objc private func autoFill() {
        let jscommand = "document.getElementById('userId').value = '18602602808' ,document.getElementById('passwd').value = '1357924680'"
        web.stringByEvaluatingJavaScriptFromString(jscommand)
    }
    
    


}
