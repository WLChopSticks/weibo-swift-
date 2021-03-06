//
//  CHSOriginalStatusTopView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/18.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class CHSOriginalStatusTopView: UIView {
    
    let iconViewWidth: CGFloat = 35
    var bottomConstraint: Constraint?
    
    //数据模型,拿到数据
    var status: CHSStatus? {
        didSet {
            //为每个子控件赋值
            let user = status?.user
            iconView.sd_setImageWithURL(user?.iconViewURL)
            nameLabel.text = user?.name
            mbrankImage.image = user?.mbrankImage
            verified_type_image.image = user?.verifiedImage
            context.text = status?.text
            //为图片视图赋数据
            picureView.imageURL = status?.imageURL
            //有无配图时和评论栏的距离,先设置一个约束,再根据不同的情况更新约束
            if picureView.imageURL?.count == 0 {
                //无图时,约束与正文相关
                self.bottomConstraint?.uninstall()
                self.snp_updateConstraints(closure: { (make) -> Void in
                    
                    self.bottomConstraint = make.bottom.equalTo(context.snp_bottom).offset(statusCellMargin).constraint
                })
            } else {
                //有图时约束与图片相关
                self.bottomConstraint?.uninstall()
                self.snp_updateConstraints(closure: { (make) -> Void in
                    self.bottomConstraint = make.bottom.equalTo(picureView.snp_bottom).offset(statusCellMargin).constraint
                })
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置布局
        decorateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decorateUI() {
        
        //添加子控件
        addSubview(iconView)
        addSubview(nameLabel)
        addSubview(mbrankImage)
        addSubview(createTime)
        addSubview(source)
        addSubview(context)
        addSubview(verified_type_image)
        //添加图片视图
        addSubview(picureView)
        addSubview(seperateView)
        
        
        //自动布局
        //分割View
        seperateView.backgroundColor = UIColor.darkGrayColor()
        seperateView.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self)
            make.height.equalTo(10)
        }
        //头像
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(seperateView.snp_bottom).offset(statusCellMargin)
            make.left.equalTo(self.snp_left).offset(statusCellMargin)
            make.size.equalTo(CGSizeMake(iconViewWidth, iconViewWidth))
        }
        //认证用户
        verified_type_image.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView.snp_right)
            make.centerY.equalTo(iconView.snp_bottom)
        }
        //名字
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_top)
            make.left.equalTo(iconView.snp_right).offset(statusCellMargin)
        }
        //等级标识
        mbrankImage.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right).offset(statusCellMargin)
            make.top.equalTo(nameLabel.snp_top)
        }
        //创建时间
        createTime.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(iconView.snp_right).offset(statusCellMargin)
            make.bottom.equalTo(iconView.snp_bottom)
        }
        //创建源
        source.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(createTime.snp_right).offset(statusCellMargin)
            make.bottom.equalTo(createTime.snp_bottom)
        }
        //正文内容
        context.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_bottom).offset(statusCellMargin)
            make.left.equalTo(self.snp_left).offset(statusCellMargin)
        }
        //图片视图
        picureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(context.snp_bottom).offset(statusCellMargin)
            make.left.equalTo(self.snp_left).offset(statusCellMargin)
        }
        
        //自身的约束
        self.snp_makeConstraints(closure: { (make) -> Void in
          self.bottomConstraint = make.bottom.equalTo(context.snp_bottom).offset(statusCellMargin).constraint
        })

    }
    
    
    //懒加载初始化控件
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private lazy var nameLabel: UILabel = UILabel(title: "这么厉害", color: themeColor, fontSize: 14)
    private lazy var mbrankImage: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    private lazy var createTime: UILabel = UILabel(title: "刚刚", color: themeColor, fontSize: 12)
    private lazy var source: UILabel = UILabel(title: "地球", color: UIColor.lightGrayColor(), fontSize: 12)
    private lazy var context: UILabel = UILabel(title: "这个状态哈哈哈哈哈哈哈哈哈这个状态哈哈哈哈哈哈哈哈哈这个状态哈哈哈哈哈哈哈哈哈这个状态哈哈哈哈哈哈哈哈哈这个状态哈哈哈哈哈哈哈哈哈", color: UIColor.darkGrayColor(), fontSize: 14, margin: statusCellMargin)
    private lazy var verified_type_image: UIImageView = UIImageView(image: UIImage(named: "avatar_vip"))
    private lazy var picureView: CHSPictureView = CHSPictureView()
    private lazy var seperateView: UIView = UIView()

}
