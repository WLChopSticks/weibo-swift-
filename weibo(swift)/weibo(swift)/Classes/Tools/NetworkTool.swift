

//
//  NetworkTool.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/21.
//  Copyright © 2015年 王. All rights reserved.
//

import AFNetworking

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
                let dic = result as! [String: AnyObject]
                finish(dic: dic, error: nil)
                }) { (_, error) -> Void in
                    print(error)
            }
        } else {
            GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                let dic = result as! [String: AnyObject]
                finish(dic: dic, error: nil)
                }, failure: { (_, error) -> Void in
                    print(error)
                    finish(dic: nil, error: error)
            })
        }
        
    
    
    }


}
