//
//  CHSStatusesViewModel.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/21.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SVProgressHUD

class CHSStatusesViewModel: NSObject {
    
    
    
    class func loadHomeControllerData(since_id: Int64,max_id: Int64, finish: (status: [CHSStatus]) -> ()) {
        let statusURL = "https://api.weibo.com/2/statuses/friends_timeline.json"
        //先判断access_token不为空
        guard let token = CHSUserAccountViewModel().userAccount?.access_token else {
            SVProgressHUD.showErrorWithStatus("请重新登陆")
            return
        }
        var parameter = ["access_token":token]
        if since_id != 0 {
            parameter["since_id"] = "\(since_id)"
        } else if max_id != 0 {
            parameter["max_id"] = "\(max_id - 1)"
        }
        //        print(token)
        NetworkTool.sharedTool.requestJSONDict(.GET, urlString: statusURL, parameters: parameter) { (dic, error) -> () in
            //            print(result)
            //获取到状态的信息,进行字典转模型
                //            print(dict["statuses"])
            if error != nil {
                return
            }
            if let statusArr = dic!["statuses"] as? [[String: AnyObject]] {
                //字典转模型,将每个模型放置到数组中
                var temp = [CHSStatus]()
                for singleStatus in statusArr {
                    let status = CHSStatus(dict: singleStatus)
                    temp.append(status)
                }
                //将装有模型的数组赋给全局变量
                finish(status: temp)

            }
        }
    }
}
