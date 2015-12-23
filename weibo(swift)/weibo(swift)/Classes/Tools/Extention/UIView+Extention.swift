//
//  UIView+Extention.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/23.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

extension UIView {
    
    func navController() -> UINavigationController? {
        var next = nextResponder()
        repeat {
            if let nextObj = next as? UINavigationController {
                return nextObj
            }
            next = next?.nextResponder()
        } while(next != nil)
        return nil
    }
    

    
}

