//
//  CHSTabBarController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabbar = CHSTabBarView()
        setValue(tabbar, forKey: "tabBar")
        tabbar.composeBtn.addTarget(self, action: "composeBtnClicking", forControlEvents: .TouchUpInside)
//        setValue(CHSTabBar(), forKey: "tabBar")
        //加载子控制器
        addChildViewcontrollers()
    }

    private func addChildViewcontrollers() {
        
        //更改主色调
        tabBar.tintColor = UIColor.orangeColor()
        
        let homeVC = CHSHomeController()
        addChildViewcontroller(homeVC, name: "首页", imageName: "tabbar_home")
        
        let messageVC = CHSMessageController()
        addChildViewcontroller(messageVC, name: "消息", imageName: "tabbar_message_center")
        
        let discoveryVC = CHSDiscoveryController()
        addChildViewcontroller(discoveryVC, name: "发现", imageName: "tabbar_discover")
        
        let profileVC = CHSProfileController()
        addChildViewcontroller(profileVC, name: "个人", imageName: "tabbar_profile")
        
    }
    
    //初始化每个子控制器
    private func addChildViewcontroller(vc: UIViewController,name: String, imageName: String) {
        vc.title = name
        vc.tabBarItem.image = UIImage(named: imageName)
        let navVC = CHSNavController(rootViewController : vc)
        addChildViewController(navVC)
    }
    
    //加号按钮被点击
    func composeBtnClicking() {
        let vc = CHSComposeController()
        let navVC = CHSNavController(rootViewController: vc)
        presentViewController(navVC, animated: true, completion: nil)
    }

}
