
//
//  CHSWelcomController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/17.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSWelcomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        将背景设置为指定的图片
        view = backImage
        
        // Do any additional setup after loading the view.
    }
    



    lazy var backImage: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
}
