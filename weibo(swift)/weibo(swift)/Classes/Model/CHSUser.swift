//
//  CHSUser.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/18.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSUser: NSObject {

    //用户UID
    var id: Int64 = 0
    //友好显示名称
    var name: String?
    //用户头像地址（中图），50×50像素
    var profile_image_url: String?
    //用户头像的URL
    var iconViewURL: NSURL? {
            return NSURL(string: profile_image_url ?? "")
    }
    //认证类型
    var verified_type: Int = -1
    //认证类型的图片
    var verifiedImage: UIImage? {
        switch verified_type {
        case 0: return UIImage(named: "avatar_vip")
        case 2,3,5 : return UIImage(named: "avatar_enterprise_vip")
        case 220 : return UIImage(named: "avatar_grassroot")
        default: return nil
        }
    }
    //会员等级
    var mbrank: Int = 0
    //会员等级对应图片
    var mbrankImage: UIImage? {
        if mbrank > 0 && mbrank < 7 {
            return UIImage(named: "common_icon_membership_level\(mbrank)")
        }
        return nil
    }
    
    
    //字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) { }
    
    //重写description方法
    override var description: String {
        let key = ["id","name","iconViewURL","verified_type","mbrank"]
        return dictionaryWithValuesForKeys(key).description
    }
    
    
}
