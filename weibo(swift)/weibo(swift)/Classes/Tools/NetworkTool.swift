

//
//  NetworkTool.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/21.
//  Copyright © 2015年 王. All rights reserved.
//

import AFNetworking

let dataErrorDomain = "com.baidu.data.error"

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
}

class NetworkTool: AFHTTPSessionManager {
    //设置一个单例
    static let sharedTool: NetworkTool = {
        let urlString = "https://api.weibo.com/"
        let url = NSURL(string: urlString)
        let share = NetworkTool(baseURL: url)
        //添加请求支持类型
        share.responseSerializer.acceptableContentTypes?.insert("text/plain")

        return share
        
    }()
    
    //封装请求方法
    func requestJSONDict(method: HTTPMethod, urlString: String, parameters: [String: String]?, finish: (dic: [String: AnyObject]?, error: NSError?) ->()) {
        if method == HTTPMethod.POST {
            POST(urlString, parameters: parameters, success: { (_, result) -> Void in
//                print(result)
                guard let dic = result as? [String: AnyObject] else {
                    //设置出错信息
                    let myError = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "数据不合法"])
                    print(myError)
                    finish(dic: nil, error: myError)
                    
                    return
                }
                finish(dic: dic, error: nil)
                }) { (_, error) -> Void in
                    print(error)
            }
        } else {
            GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                guard let dic = result as? [String: AnyObject] else {
                    //设置出错信息
                    let myError = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "数据不合法"])
                    print(myError)
                    finish(dic: nil, error: myError)
                    
                    return
                }
                finish(dic: dic, error: nil)
                }) { (_, error) -> Void in
                    print(error)

            }
        }
        
    
    
    }
    
    
//    func uploadImage(urlString: String,parameters:[String : String]?,imageData: NSData, finished: (dict: [String : AnyObject]?, error: NSError?) -> ()) {
//        
//        POST(urlString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
//            //将图片的二进制数据添加formData中
//            /**
//            *   data 需要上传的文件的二进制数据
//            name: 服务器接收上传文件的需要对应字段
//            fileName: 服务器存储的名称 随便取  新浪微博 会自己去更改名字
//            mimeType: 上传的文件的类型
//            */
//            formData.appendPartWithFileData(imageData, name: "pic", fileName: "xxoo", mimeType: "image/jpeg")
//            }, progress: { (p) -> Void in
//                print(p)
//            }, success: { (_, result) -> Void in
//                //上传成功
//                print(result)
//                if let dict = result as? [String : AnyObject] {
//                    finished(dict: dict, error: nil)
//                }
//                
//            }) { (_, error) -> Void in
//                //上传失败
//                finished(dict: nil, error: error)
//                print(error)
//        }
//    }

    
    func uploadImage(urlString: String, parameters: [String:String]?,imageData: NSData, finish: (dic: [String:AnyObject]?, error: NSError?) -> ()) {
        
        
        POST(urlString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
            //将图片的二进制数据添加formData中
            /**
            *   data 需要上传的文件的二进制数据
            name: 服务器接收上传文件的需要对应字段
            fileName: 服务器存储的名称 随便取  新浪微博 会自己去更改名字
            mimeType: 上传的文件的类型
            */
            formData.appendPartWithFileData(imageData, name: "pic", fileName: "xxoo", mimeType: "image/jpeg")
            }, success: { (_, result) -> Void in
                //上传成功
                print(result)
                if let dict = result as? [String : AnyObject] {
                    finish(dic: dict, error: nil)
                }
                
            }) { (_, error) -> Void in
                //上传失败
                finish(dic: nil, error: error)
                print(error)
        }

        
        
        
        
//        POST(urlString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
////        POST(urlString, parameters: parameters, constructingBodyWithBlock: { (formData) -> Void in
////            formData.appendPartWithFileData(imageData, name: "pic", fileName: "hehe", mimeType: "image/jpeg")
//            formData.appendPartWithFileData(imageData, name: "pic", fileName: "xxoo", mimeType: "image/jpeg")
//            }, success: { (_, result) -> Void in
//                guard let dic = result as? [String: AnyObject] else {
//                    //设置出错信息
//                    let myError = NSError(domain: dataErrorDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey : "数据不合法"])
//                    print(myError)
//                    
//                    finish(dic: nil, error: myError)
//                    
//                    return
//                }
//                finish(dic: dic, error: nil)
//            }) { (_, error) -> Void in
//                print(error)
//        }
    }


}
