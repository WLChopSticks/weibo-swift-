//
//  CHSComposeController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/23.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SVProgressHUD

class CHSComposeController: UIViewController {

    func sendBtnClicking() {
        print("发送按钮")
        //发送微博
        let updateURL = "https://api.weibo.com/2/statuses/update.json"
        guard let access = CHSUserAccountViewModel().userAccount?.access_token else {
            SVProgressHUD.showInfoWithStatus("请重新登陆")
            return
        }
        let parameter = ["access_token":access, "status":text.text ?? ""]
        NetworkTool.sharedTool.requestJSONDict(.POST, urlString: updateURL, parameters: parameter) { (dic, error) -> () in
            if error != nil {
                SVProgressHUD.showErrorWithStatus("发送微博错误")
                return
            }
            SVProgressHUD.showSuccessWithStatus("发送微博成功")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func returnBtnClicking() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        decorateNavBar()
        decorateTextView()
        
        // Do any additional setup after loading the view.
    }
    
    func decorateTextView() {
        view.addSubview(text)
        text.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(screenHeight / 3)
        }
        
        text.addSubview(placeholderLabel)
        placeholderLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(text.snp_top).offset(8)
            make.left.equalTo(text.snp_left).offset(5)
        }
    }
    
    
    func decorateNavBar() {
        
        //设置左右按钮
        let sendBtn = UIBarButtonItem(title: "发送", style: .Plain, target: self, action: "sendBtnClicking")
        let returnBtn = UIBarButtonItem(title: "返回", style: .Plain, target: self, action: "returnBtnClicking")
        sendBtn.enabled = false
        navigationItem.leftBarButtonItem = returnBtn
        navigationItem.rightBarButtonItem = sendBtn
        
        
        //设置标题的View
        let titleV = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        
        let headline = UILabel(title: "发微博", color: UIColor.darkGrayColor(), fontSize: 17)
        let name = UILabel(title: CHSUserAccountViewModel().userAccount?.name ?? "", color: UIColor.darkGrayColor(), fontSize: 14)
        
        titleV.addSubview(headline)
        titleV.addSubview(name)
        navigationItem.titleView = titleV
        
        //添加约束
        headline.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleV.snp_centerX)
            make.top.equalTo(titleV.snp_top)
        }
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(headline.snp_bottom)
            make.centerX.equalTo(titleV.snp_centerX)
        }
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var placeholderLabel: UILabel = UILabel(title: "请输入文本", color: UIColor.darkGrayColor(), fontSize: 14)

    lazy var text: UITextView = {
        let t = UITextView()
        t.backgroundColor = randomColor()
        t.delegate = self
        //让其可以滑动
        t.alwaysBounceVertical = true
        
        return t
    }()
}


extension CHSComposeController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
}
