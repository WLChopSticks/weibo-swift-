//
//  CHSUserAccount.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/17.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSUserAccount: NSObject, NSCoding {

    var access_token: String?
    var expires_in: NSTimeInterval = 0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    
    }
//    var remind_in: String?
    var uid: String?
    
    //添加用户名和图片属性
    var name: String?
    var avatar_large: NSURL?
    
    //添加token过期时间
    var expires_date: NSDate?
    
    
    //增加字典转模型方法
    init(dic: [String : AnyObject]) {
    
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    //为没有数据的模型提供方法,防止程序崩溃
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
    
    
    //设置归档解档的代理方法
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeDoubleForKey("expires_in")
        uid = aDecoder.decodeObjectForKey("uid") as? String
        name = aDecoder.decodeObjectForKey("name") as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? NSURL
        expires_date = aDecoder.decodeObjectForKey("expires_date") as? NSDate
  
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeDouble(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(expires_date, forKey: "expires_date")
    }
    
    
    //将信息保存起来
    func saveUserAccount() {

        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString
        let filePath = path.stringByAppendingPathComponent("userAccount.plist")
        //保存
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    //读取用户信息
    class func loadUserAccount() -> CHSUserAccount? {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! as NSString
        let filePath = path.stringByAppendingPathComponent("userAccount.plist")
        //读取
        if let userAccount = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? CHSUserAccount {
            //存储的token的有效时间和当前时间的对比
            if userAccount.expires_date?.compare(NSDate()) == NSComparisonResult.OrderedDescending {
                return userAccount
            }
        }
        return nil
    }
    
}
