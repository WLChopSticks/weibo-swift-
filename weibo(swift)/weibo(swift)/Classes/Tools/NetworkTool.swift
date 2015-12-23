

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


}
