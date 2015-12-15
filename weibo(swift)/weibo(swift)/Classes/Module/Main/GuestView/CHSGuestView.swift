//
//  CHSGuestView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSGuestView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        addSubview(logInBtn)
        addSubview(largeIcon)
        addSubview(circleImage)
        addSubview(infoLabel)
        addSubview(registBtn)
        
        logInBtn.frame = CGRectMake(100, 100, 100, 100)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        //中间图片的frame
        largeIcon.center.y = self.center.y - 60
        largeIcon.center.x = self.center.x
        
        circleImage.center = largeIcon.center
        
//        infoLabel.center.y = circleImage.frame.origin.y + circleImage.bounds.height + 20
//        infoLabel.center.x = circleImage.center.x
//        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 10))
//        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: -10))
//        addConstraint(NSLayoutConstraint(item: infoLabel, attribute: .Height, relatedBy: .GreaterThanOrEqual, toItem: nil, attribute: .Height, multiplier: 1, constant: 30))
        infoLabel.frame = CGRectMake(20, circleImage.frame.origin.y + circleImage.bounds.height , UIScreen.mainScreen().bounds.width - 40, 60)
        
        let margin:CGFloat = 30
        let btnW = (UIScreen.mainScreen().bounds.width - margin * 2) / 2 - margin / 2
        logInBtn.frame = CGRectMake(margin, infoLabel.frame.origin.y + 80, btnW, 35)
        registBtn.frame = CGRectMake(margin + margin + btnW, infoLabel.frame.origin.y + 80, btnW, 35)

        
        

        
        
    }
    
    

    
    
    lazy var largeIcon: UIImageView = {
        let large = UIImageView()
        large.image = UIImage(named: "visitordiscover_feed_image_house")
        large.sizeToFit()
        return large
    }()
    
    lazy var circleImage: UIImageView = {
        let circle = UIImageView()
        circle.image = UIImage(named: "visitordiscover_feed_image_smallicon")
        circle.sizeToFit()
        return circle
    }()
    
    lazy var infoLabel: UILabel = {
        let info = UILabel()
        info.numberOfLines = 0
        info.textColor = UIColor.darkGrayColor()
        info.textAlignment = .Center
        info.text = "我是一个大好人我是一个大好人我是一个大好人我是一个大好人"
        return info
    }()
    
    lazy var logInBtn: UIButton = {
        let logIn = UIButton()
        logIn.setTitle("登陆", forState: .Normal)
        logIn.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        let btnImage2 = UIImage(named: "common_button_white_disable")
        let btnImage = btnImage2?.resizableImageWithCapInsets(UIEdgeInsetsMake((btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5, (btnImage2?.size.height)! * 0.5, (btnImage2?.size.width)! * 0.5))
        logIn.setBackgroundImage(btnImage, forState: .Normal)
        return logIn
    }()
    
    lazy var registBtn: UIButton = {
        let regist = UIButton()
        regist.setTitle("注册", forState: .Normal)
        regist.setTitleColor(themeColor, forState: .Normal)
        let registImage = UIImage(named: "common_button_white_disable")
        let registEdge = registImage?.resizableImageWithCapInsets(UIEdgeInsetsMake((registImage?.size.height)! * 0.5, (registImage?.size.width)! * 0.5, (registImage?.size.height)! * 0.5, (registImage?.size.width)! * 0.5))
        regist.setBackgroundImage(registEdge, forState: .Normal)
        return regist
    }()
    
}
