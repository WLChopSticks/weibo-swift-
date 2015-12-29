//
//  CHSComposeController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/23.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SVProgressHUD
import SnapKit


private let toolBarHeight = 44

class CHSComposeController: UIViewController {

    func sendBtnClicking() {
//        print("发送按钮")
        //发送微博
        var updateURL = "https://api.weibo.com/2/statuses/update.json"
        guard let access = CHSUserAccountViewModel().userAccount?.access_token else {
            SVProgressHUD.showInfoWithStatus("请重新登陆")
            return
        }
        let parameter = ["access_token":access, "status":text.text ?? ""]
        if uploadPicture.pictureArr.count == 0 {
            NetworkTool.sharedTool.requestJSONDict(.POST, urlString: updateURL, parameters: parameter) { (dic, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("发送微博错误")
                    return
                }
                SVProgressHUD.showSuccessWithStatus("发送微博成功")
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        } else {
            updateURL = "https://upload.api.weibo.com/2/statuses/upload.json"
            let image = uploadPicture.pictureArr.first
//            let imageData = UIImagePNGRepresentation(image!)!
            let imageData = UIImageJPEGRepresentation(image!, 0.1)!
//            SVProgressHUD.showWithStatus("请等待")
           NetworkTool.sharedTool.uploadImage(updateURL, parameters: parameter, imageData: imageData, finish: { (dic, error) -> () in

//            SVProgressHUD.dismiss()
            if error != nil {
                SVProgressHUD.showErrorWithStatus("发送微博错误")
                return
            }
            SVProgressHUD.showSuccessWithStatus("发送微博成功")
            self.dismissViewControllerAnimated(true, completion: nil)
            

           })
            
        }

        
    }
    
    func returnBtnClicking() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //在出现的时候自动调出键盘,关闭的时候让键盘消失
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        text.resignFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        text.becomeFirstResponder()
        
        decorateNavBar()
        decorateTextView()
        decorateUploadPicture()
        //添加工具栏
        decorateToolBar()
        
        
        //注册一个通知,检测键盘的位置
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    //检测到通知的方法
    func keyboardWillChange(notice: NSNotification) {
        let time = (notice.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! NSNumber).doubleValue
        let loc = (notice.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).CGRectValue()
//        print(notice)
        //更新toolbar约束
        let offsetY = loc.origin.y - screenHeight
        toolBar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(offsetY)
        }
        UIView.animateWithDuration(time) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    
    //布局工具栏
    func decorateToolBar() {
        var toolBarBtn = [UIBarButtonItem]()
        let toolBarBtnItems = [["imageName": "compose_toolbar_picture","actionName":"selectPicture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background","actionName":"selectEmoticonKeyboard"],
            ["imageName": "compose_add_background"]]
        for item in toolBarBtnItems {
            
            let imageName = item["imageName"]
            let btn = UIButton(title: nil, titleColor: themeColor, backImage: nil, imageName: imageName)
            if let action = item["actionName"] {
                btn.addTarget(self, action: Selector(action), forControlEvents: .TouchUpInside)
            }
            let barBtn = UIBarButtonItem(customView: btn)
            toolBarBtn.append(barBtn)

            let flexBtn = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            toolBarBtn.append(flexBtn)
            
        }
        
        //移除最后一个弹簧
        toolBarBtn.removeLast()
        
        toolBar.items = toolBarBtn
        view.addSubview(toolBar)
        
        //添加约束
        toolBar.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(toolBarHeight)
        }
        
        
    }
    
    //实现toolBar的点击方法
    func selectPicture() {
//        print(__FUNCTION__)
        text.resignFirstResponder()
        
        uploadPicture.view.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(screenHeight * 2 / 3)
        }

        UIView.animateWithDuration(0.25) { () -> Void in
            self.view.layoutIfNeeded()
        }
//        toolBar.snp_updateConstraints { (make) -> Void in
//            make.bottom.equalTo(pictureVC.view.snp_top)
//        }

    }
    
    func decorateUploadPicture() {
       
        addChildViewController(uploadPicture)
        view.addSubview(uploadPicture.view)
        uploadPicture.view.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            //            make.top.equalTo(text.snp_bottom)
            make.height.equalTo(0)
        }
    }
    
    func selectEmoticonKeyboard() {
        print(__FUNCTION__)
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
        //设置滑动使键盘消失
        t.keyboardDismissMode = .OnDrag
        
        return t
    }()
    
    lazy var toolBar: UIToolbar = UIToolbar()
    lazy var uploadPicture: CHSUploadPictureController = CHSUploadPictureController()
}


extension CHSComposeController: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
}
