//
//  CHSStatusCell.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/18.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SnapKit

class CHSStatusCell: UITableViewCell {
    //评论栏的底部约束
    var originalBottomViewTopConstraint: Constraint?
    
    
    //获取数据并传递数据
    var status: CHSStatus? {
        didSet {
            originalTopView.status = status
            
            //根据是原创微博还是转发微博来计算评论栏的位置
            if let status = status?.retweeted_status {
                self.originalBottomViewTopConstraint?.uninstall()
                retweetView.hidden = false
                //给转发视图传递数据
                retweetView.status = status
                originalBottomView.snp_updateConstraints(closure: { (make) -> Void in
                   self.originalBottomViewTopConstraint = make.top.equalTo(retweetView.snp_bottom).offset(statusCellMargin).constraint
                })
            } else {
                self.originalBottomViewTopConstraint?.uninstall()
                retweetView.hidden = true
                originalBottomView.snp_updateConstraints(closure: { (make) -> Void in
                    self.originalBottomViewTopConstraint = make.top.equalTo(originalTopView.snp_bottom).offset(0).constraint
                })
            }

        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //界面布局
        decorateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func decorateUI() {
        contentView.addSubview(originalTopView)
        contentView.addSubview(originalBottomView)
        contentView.addSubview(retweetView)
        
        
        //自动布局
        //topview
        originalTopView.snp_makeConstraints { (make) -> Void in
//            make.top.left.right.equalTo(contentView)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.top.equalTo(contentView.snp_top)
//            make.height.equalTo(100)
        }
        //retweetView
        retweetView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(originalTopView.snp_bottom)
//            make.height.equalTo(100)
            make.left.right.equalTo(contentView)
        }
        
        
        //bottomView
        originalBottomView.snp_makeConstraints { (make) -> Void in
           self.originalBottomViewTopConstraint = make.top.equalTo(originalTopView.snp_bottom).constraint
            make.left.right.equalTo(self)
            make.height.equalTo(40)
        }
        
        //自身的行高,所有的控件都添加到contentView,约束也要设定contentView
        contentView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(originalBottomView.snp_bottom).offset(10)
        }
        
    }
    
    
    //懒加载初始化控件
    private lazy var originalTopView: CHSOriginalStatusTopView = CHSOriginalStatusTopView()
    private lazy var originalBottomView: CHSOriginalBottomView = CHSOriginalBottomView()
    private lazy var retweetView: CHSRetweetStatusView = CHSRetweetStatusView()
    
}
