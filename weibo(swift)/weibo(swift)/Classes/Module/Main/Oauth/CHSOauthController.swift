//
//  CHSOauthController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/16.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

class CHSOauthController: UIViewController {

    
    let web = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将View替换成webView 用来显示登陆页面
        view = web
        
        //设置代理
        web.delegate = self
        
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



//扩展控制器方法,获取回调信息
extension CHSOauthController: UIWebViewDelegate {

    //显示加载视图
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    //关闭加载视图
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    //屏蔽一些不需要的页面
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        
        guard let urlString = request.URL?.absoluteString else {
            return false
        }
        //屏蔽注册的页面
        if urlString.hasPrefix("http://weibo.cn/dpool/ttt/h5/reg.php") {
            return false
        }
        //屏蔽换账号的按钮
        if urlString.hasPrefix("http://login.sina.com.cn/sso/logout.php") {
            return false
        }
        
        if urlString.hasPrefix("https://api.weibo.com/oauth2/authorize") {
            return true
        }
        //屏蔽百度页面回调的按钮
        if !urlString.hasPrefix("http://www.baidu.com") {
            return false
        }

        //拿到code号
        //拿到参数
        if let query = request.URL?.query {
            
            let recogStr = "code="
            //获取到code号
            let code = query.substringFromIndex(recogStr.endIndex)

            
            loadAccessToken(code)
        }
  
        return false
    }
    
    
    //获取access_token信息
    func loadAccessToken(code: String) {
        
        CHSUserAccountViewModel().loadAccessToken(code) { (isSuccess) -> () in
            if isSuccess {
                print("登陆成功")
                self.returnMain()
                NSNotificationCenter.defaultCenter().postNotificationName(changeRootViewController, object: nil)
            }else {
                print("登陆失败")
            }
        }
    }






}
