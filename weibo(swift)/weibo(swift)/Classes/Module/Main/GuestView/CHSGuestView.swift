//
//  CHSGuestView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

@objc protocol guestViewDelegate: NSObjectProtocol {
    func registButtonClicking()
    func logInButtonClicking()
}

class CHSGuestView: UIView {
    

    //设置协议属性
    weak var delegate: guestViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(circleImage)
        addSubview(cover)
        addSubview(logInBtn)
        addSubview(largeIcon)
        addSubview(infoLabel)
        addSubview(registBtn)
        
        //监控两个按钮
        registBtn.addTarget(self, action: "registClicking", forControlEvents: .TouchUpInside)
        logInBtn.addTarget(self, action: "logInClicking", forControlEvents: .TouchUpInside)
    }
    
    @objc func registClicking() {
        delegate?.registButtonClicking()
    }
    @objc func logInClicking() {
        delegate?.logInButtonClicking()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //对外提供一个方法,让其传图片和文字进来
    func setInfoAndImage(info: String, imageNmae: String?) {
        infoLabel.text = info
        if let imageStr = imageNmae {
            largeIcon.hidden = true
            circleImage.image = UIImage(named: imageStr)
            bringSubviewToFront(circleImage)
        }else {
            //就是主页面
            //开启动画
            animationWithCircleImage()
        }
    }
    
    override func layoutSubviews() {
        //中间图片的frame
        largeIcon.center.y = self.center.y - 60
        largeIcon.center.x = self.center.x
        
        circleImage.center = largeIcon.center
        
        infoLabel.frame = CGRectMake(20, circleImage.frame.origin.y + circleImage.bounds.height , UIScreen.mainScreen().bounds.width - 40, 60)
        
        let margin:CGFloat = 30
        let btnW = (UIScreen.mainScreen().bounds.width - margin * 2) / 2 - margin / 2
        logInBtn.frame = CGRectMake(margin, infoLabel.frame.origin.y + 80, btnW, 35)
        registBtn.frame = CGRectMake(margin + margin + btnW, infoLabel.frame.origin.y + 80, btnW, 35)
        
        cover.frame = CGRectMake(0, circleImage.center.y - circleImage.bounds.height * 0.6, UIScreen.mainScreen().bounds.width, circleImage.bounds.height)

        backgroundColor = UIColor.init(white: 0.93, alpha: 1)
 
    }
    
    
    
    
    //设置主页面的旋转动画
    private func animationWithCircleImage() {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.duration = 10
        animation.repeatCount = MAXFLOAT
        animation.toValue = 2 * M_PI
        animation.removedOnCompletion = false
        
        circleImage.layer.addAnimation(animation, forKey: nil)
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
    
    
    lazy var infoLabel: UILabel = UILabel.init(title: "", color: UIColor.darkGrayColor(), fontSize: 16)
    
    
    lazy var logInBtn: UIButton = UIButton.init(title: "登陆", titleColor: UIColor.darkGrayColor(), backImage: "common_button_white_disable")
    
    lazy var registBtn: UIButton = UIButton.init(title: "注册", titleColor: themeColor, backImage: "common_button_white_disable")
        
    lazy var cover: UIImageView = {
        let coverImg = UIImageView()
        coverImg.image = UIImage(named: "visitordiscover_feed_mask_smallicon")
        return coverImg
    }()
    
}
