//
//  CHSStatus.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/18.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSStatus: NSObject {

    //微博创建时间
    var created_at: String?
    //微博ID
    var id:Int64 = 0
    //微博信息内容
    var text: String?
    //微博来源
    var source: String?
    //缩略图片地址，没有时不返回此字段
    var thumbnail_pic: String?
    //用户信息模型
    var user: CHSUser?
    //每个状态的配图
    var pic_urls: [[String : String]]? {
        didSet {
            guard let urls = pic_urls else {
                print("图片的URL为空")
                return
            }
            imageURL = [NSURL]()
            for URLDict in urls {
                let URLString = URLDict["thumbnail_pic"]!
                let url = NSURL(string: URLString)!
                imageURL?.append(url)
            }
        }
    }
    var imageURL: [NSURL]?
    
    //字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //在字典转模型的过程中,筛选出用户的模型再转一次
    override func setValue(value: AnyObject?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "user" {
            guard let dict = value as? [String: AnyObject] else {
                return
            }
            user = CHSUser(dict: dict)
        }
    }
    
    //为没有属性的键值对的方法
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {  }
    
    
    //重写description方法
    override var description:String {
        let key = ["user"]
        return dictionaryWithValuesForKeys(key).description
    }
    
    
    
    
    
    
    
}
