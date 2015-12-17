
//
//  CHSWelcomController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/17.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SnapKit

class CHSWelcomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //将背景设置为指定的图片
        view = backImage
        //界面布局
        UILayout()
        
               // Do any additional setup after loading the view.
    }
    
    private func UILayout() {
        //将头像和欢迎文字添加上去
        view.addSubview(iconView)
        view.addSubview(nameLabel)
        
        //设置约束
        iconView.layer.cornerRadius = 40
        iconView.layer.masksToBounds = true
        iconView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.snp_centerX)
            make.bottom.equalTo(view.snp_bottom).offset(-200)
        }
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_centerX)
            make.top.equalTo(iconView.snp_bottom).offset(15)
        }

    }
    
    
    override func viewDidAppear(animated: Bool) {
        showAnimaiton()
    }
    
    //添加动画
    func showAnimaiton() {
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 9, options: [], animations: { () -> Void in

            let offset =  -UIScreen.mainScreen().bounds.height + 200
            self.iconView.snp_updateConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(self.view.snp_bottom).offset(offset)
            })
            self.view.layoutIfNeeded()

            
            }) { (_) -> Void in
                print("ok")
                NSNotificationCenter.defaultCenter().postNotificationName(changeRootViewController, object: nil)
        }
        

    }



    lazy var backImage: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    lazy var nameLabel: UILabel = UILabel(title: "欢迎回来", color: UIColor.darkGrayColor(), fontSize: 14)
}
