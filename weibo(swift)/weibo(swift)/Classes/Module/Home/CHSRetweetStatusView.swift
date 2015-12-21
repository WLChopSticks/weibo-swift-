//
//  CHSRetweetStatusView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/21.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SnapKit

class CHSRetweetStatusView: UIView {
    
    //全局底部约束
    var bottomConstraint: Constraint?
    
    var status: CHSStatus? {
        didSet {
            retweetContext.text = "@" + "\(status?.user?.name ?? "")" + "\(status?.text ?? "")"
            pictureView.imageURL = status?.imageURL
            
            //转发微博有图和无图的时候底部约束更新
            if let url = status?.imageURL {
                self.bottomConstraint?.uninstall()
                self.snp_makeConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(pictureView.snp_bottom).constraint
                })
            } else {
                self.bottomConstraint?.uninstall()
                self.snp_makeConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(retweetContext.snp_bottom).constraint
                })
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.93, alpha: 1)
        
        //设置UI视图
        decorateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置UI
    func decorateUI() {
        addSubview(retweetContext)
        addSubview(pictureView)
        
        //添加约束
        retweetContext.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left).offset(statusCellMargin)
        }
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(retweetContext.snp_bottom).offset(statusCellMargin)
            make.left.equalTo(self.snp_left).offset(statusCellMargin)
        }
        self.snp_makeConstraints { (make) -> Void in
            self.bottomConstraint = make.bottom.equalTo(pictureView.snp_bottom).constraint
        }
        
        
    
    }
    

    //懒加载并初始化视图
    lazy var retweetContext: UILabel = UILabel(title: "是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗是人吗", color: UIColor.darkGrayColor(), fontSize: 14, margin: statusCellMargin)
    lazy var pictureView: CHSPictureView = CHSPictureView()

}
