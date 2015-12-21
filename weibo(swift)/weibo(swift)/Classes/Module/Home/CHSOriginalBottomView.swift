//
//  CHSOriginalBottomView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/18.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSOriginalBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.yellowColor()

        //设置页面
        decorateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //设置页面
    func decorateUI() {
        addSubview(retweetBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        let seperate1 = seperateView()
        let seperate2 = seperateView()
        addSubview(seperate1)
        addSubview(seperate2)
        addSubview(seperateLine)
        
        //设置约束
        retweetBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.snp_left)
            make.top.bottom.equalTo(self)
        }
        commentBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetBtn.snp_right)
            make.width.equalTo(retweetBtn.snp_width)
            make.top.bottom.equalTo(self)
        }
        likeBtn.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commentBtn.snp_right)
            make.width.equalTo(commentBtn.snp_width)
            make.right.equalTo(self.snp_right)
            make.top.bottom.equalTo(self)
        }
        
        //加入横向分割下
        seperateLine.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo(0.5)
            
        }
        
        //加入分割线
        seperate1.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(retweetBtn.snp_right)
            make.centerY.equalTo(retweetBtn.snp_centerY)
            make.width.equalTo(0.5)
            make.height.equalTo(retweetBtn.snp_height).multipliedBy(0.6)
        }
        seperate2.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(commentBtn.snp_right)
            make.centerY.equalTo(commentBtn.snp_centerY)
            make.width.equalTo(0.5)
            make.height.equalTo(commentBtn.snp_height).multipliedBy(0.6)
        }
        
        
    }
    
    
    
    //懒加载初始化控件
    //转发按钮
    private lazy var retweetBtn: UIButton = UIButton(title: "转发", titleColor: UIColor.lightGrayColor(), backImage: nil, imageName: "timeline_icon_retweet")
    //评论按钮
    private lazy var commentBtn: UIButton = UIButton(title: "评论", titleColor: UIColor.lightGrayColor(), backImage: nil, imageName: "timeline_icon_comment")
    //点赞按钮
    private lazy var likeBtn: UIButton = UIButton(title: "赞", titleColor: UIColor.lightGrayColor(), backImage: nil, imageName: "timeline_icon_unlike")
    //生成与其他视图分离的分割线
    private lazy var seperateLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGrayColor()
        return view
    }()
    //生成分割线
    private func seperateView () -> UIView {
        let sep = UIView()
        sep.backgroundColor = UIColor.lightGrayColor()
        return sep
    }
    
}
