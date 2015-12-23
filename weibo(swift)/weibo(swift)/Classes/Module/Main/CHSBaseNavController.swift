//
//  CHSBaseNavController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/23.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSBaseNavController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置手势识别的代理
        self.interactivePopGestureRecognizer?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count != 0 {
            let btn = UIButton(title: "返回", titleColor: themeColor, backImage: nil, imageName:"navigationbar_back_withtext")
            btn.setImage(UIImage(named: "navigationbar_back_withtext_highlighted"), forState: .Highlighted)
            btn.addTarget(self, action: "returnButtonClicking", forControlEvents: .TouchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        }
        
        
        super.pushViewController(viewController, animated: animated)
        
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.childViewControllers.count > 0
    }
    
    //返回按钮的点击事件
    func returnButtonClicking() {
        popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
