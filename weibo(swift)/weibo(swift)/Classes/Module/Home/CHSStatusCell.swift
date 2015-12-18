//
//  CHSStatusCell.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/18.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

class CHSStatusCell: UITableViewCell {
    
    //获取数据并传递数据
    var status: CHSStatus? {
        didSet {
            originalTopView.status = status
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
        
        
        //自动布局
        //topview
        originalTopView.snp_makeConstraints { (make) -> Void in
//            make.top.left.right.equalTo(contentView)
            make.left.equalTo(contentView.snp_left)
            make.right.equalTo(contentView.snp_right)
            make.top.equalTo(contentView.snp_top)
//            make.height.equalTo(100)
        }
        
        //bottomView
        originalBottomView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(originalTopView.snp_bottom).offset(statusCellMargin)
            make.left.right.equalTo(self)
            make.height.equalTo(30)
        }
        
    }
    
    
    //懒加载初始化控件
    private lazy var originalTopView: CHSOriginalStatusTopView = CHSOriginalStatusTopView()
    private lazy var originalBottomView: CHSOriginalBottomView = CHSOriginalBottomView()
    
}
