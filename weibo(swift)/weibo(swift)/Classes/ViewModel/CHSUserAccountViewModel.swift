//
//  CHSUserAccountViewModel.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/17.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import AFNetworking

class CHSUserAccountViewModel: NSObject {
    
    var userAccount: CHSUserAccount?
    
    //初始化方法,为userAccount赋值
    override init() {
        userAccount = CHSUserAccount.loadUserAccount()
    }
    
    var userIsLogIn: Bool {
        return userAccount?.access_token != nil
    }
    
    //获取用户头像
    var iconimage: NSURL? {
        return NSURL(string: userAccount?.avatar_large ?? "")
    }
    
    
    //获取access_token信息
    func loadAccessToken(code: String, finish: (isSuccess: Bool) -> ()) {
        
        
        //获取access_token的URL
        let tockenURL = "https://api.weibo.com/oauth2/access_token"
        let parameter = ["client_id":client_id,"client_secret":client_secret,"grant_type":"authorization_code","code":code,"redirect_uri":redirect_uri]
        NetworkTool.sharedTool.requestJSONDict(.POST, urlString: tockenURL, parameters: parameter) { (dic, error) -> () in
            //成功获取access_token后进行字典转模型
            if error != nil {
                print(error)
                
                return
            }
            let userAccount = CHSUserAccount(dic: dic!)
            //获取用户信息
            self.loadUserInformation(userAccount, finish: finish)

        }

        
    }
    
    //获取用户信息
    func loadUserInformation(userAccount: CHSUserAccount, finish: (isSuccess: Bool) -> ()) {
        let userInfoURL = "https://api.weibo.com/2/users/show.json"
        //字典中不能存放nil
        if let token = userAccount.access_token, uid = userAccount.uid {
            let parameter = ["access_token": token,"uid": uid]
            
            
        NetworkTool.sharedTool.requestJSONDict(.GET, urlString: userInfoURL, parameters: parameter, finish: { (dic, error) -> () in
            if error != nil {
                return
            }
            //获取用户的名字和图片的URL,并赋值给模型
            userAccount.name = dic!["name"] as? String
            userAccount.avatar_large = dic!["avatar_large"] as? String
            //将信息保存到本地
            userAccount.saveUserAccount()
            finish(isSuccess: true)  
            
            })
            
        }
        
    }


}
