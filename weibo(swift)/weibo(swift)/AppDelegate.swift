//
//  AppDelegate.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //初始化窗口,将其设置为自定义的tabbar控制器
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        let vc = CHSTabBarController()
//        
//        
//        let welcom = CHSComposeController()
//        let navVC = CHSNavController(rootViewController: welcom)
//        let picture = CHSUploadPictureController()
//        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        setWordColor()
        //注册通知
        registNotificationCenter()
        
        //选择进入的控制器页面
        defaultViewControllerToEnter()
        
        
        
        return true
    }
    
    //设置主题颜色
    func setWordColor() {
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
    }
    
    //判断是否是新版本
    func isNewVersion() -> Bool {
        //获取当前软件版本
        let info = NSBundle.mainBundle().infoDictionary
        let ver = info!["CFBundleShortVersionString"] as! String
        let version = Double(ver)
        //获取缓存的版本号
        let localVerson = NSUserDefaults.standardUserDefaults().doubleForKey("version")
        
        //存储当前版本号
        NSUserDefaults.standardUserDefaults().setDouble(version!, forKey: "version")
        print(version)
        return version > localVerson
    }
    
    //设置默认进入的控制器页面
    func defaultViewControllerToEnter() {
        if isNewVersion() {
            //是新版本进入新特性页面
            window?.rootViewController = CHSNewFeatureController()
        }else {
            //不是新版本进入欢迎页面
            window?.rootViewController = CHSWelcomController()
        }
    }
    
    //注册通知
    func registNotificationCenter() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeRootVC:", name: changeRootViewController, object: nil)
    }
    //移除通知
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func changeRootVC(notice: NSNotification) {
 
        if notice.object != nil {
            window?.rootViewController = CHSWelcomController()
            return
        }
        window?.rootViewController = CHSTabBarController()
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

