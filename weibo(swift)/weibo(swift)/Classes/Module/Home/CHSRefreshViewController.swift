
//
//  CHSRefreshViewController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/23.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit

let refreshViewHeight: CGFloat = 60
//定义下拉的三种状态
enum states: Int {
    case Normal = 0
    case Pulling = 1
    case Refreshing = 2
}

class CHSRefreshViewController: UIControl {
    
    //保存上一次的状态
    var oldStat: states = .Normal
    var stat: states = .Normal {
        didSet {
            switch stat {
            case .Pulling:
                if oldStat != .Pulling {
                    oldStat = stat
                    tipLabel.text = "松手刷新"
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.arrowImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    })
                }
            case .Refreshing:
                oldStat = stat
                arrowImage.hidden = true
                indicator.hidden = false
                tipLabel.text = "正在刷新"
                indicator.startAnimating()
                //刷新时将刷新界面露出来
                var inset = scrollView!.contentInset
                inset.top += refreshViewHeight
                scrollView?.contentInset = inset
                sendActionsForControlEvents(.ValueChanged)
                
                print("进入刷新状态")
            case .Normal:
                oldStat = stat
                tipLabel.text = "下拉刷新"
                self.arrowImage.hidden = false
                self.indicator.stopAnimating()
                //结束刷新时将刷新界面隐藏
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    var inset = self.scrollView!.contentInset
                    inset.top -= refreshViewHeight
                    self.scrollView?.contentInset = inset
                })
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.arrowImage.transform = CGAffineTransformMakeRotation(CGFloat(0))
                })
                
                
            }
        }
    }
    
    func endRefresh() {
//        let times = dispatch_time(DISPATCH_TIME_NOW, Int64(1) * Int64(NSEC_PER_SEC))
//        dispatch_after(times, dispatch_get_main_queue()) { () -> Void in
            self.stat = .Normal
//        }
    }
    
    //实现KVO方法
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {

        //获取默认的偏移值
        let contentInset = scrollView?.contentInset.top ?? 0
        let contentOffset = scrollView?.contentOffset.y ?? 0
        let value = -(contentInset + refreshViewHeight)
//        print(contentOffset,contentInset,value)
        if scrollView!.dragging {
            if state == .Normal && value > contentOffset {
                stat = .Pulling
            } else if stat == .Pulling && value < contentOffset {

                stat = .Normal
            }
            
        }else if stat == .Pulling && value < contentOffset {

            stat = .Refreshing
        }
        

        
        
        
        
        
    }

    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        if let father = newSuperview as? UIScrollView {
            self.scrollView = father
            //添加观察者
            self.scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        }
        
    }
    
    //移除观察者
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override init(frame: CGRect) {
        //设置自身大小
        let rect = CGRectMake(0, -refreshViewHeight, screenWidth, refreshViewHeight)
        super.init(frame: rect)
        backgroundColor = randomColor()
//        self.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        //加载视图
        decorateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init method don't implement")
    }
    
    //加载视图
    func decorateUI() {
        addSubview(tipLabel)
        addSubview(arrowImage)
        addSubview(indicator)
        
        //设置约束
        tipLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).offset(20)
            make.centerY.equalTo(self.snp_centerY)
        }
        arrowImage.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).offset(-20)
            make.centerY.equalTo(self.snp_centerY)
        }
        indicator.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp_centerX).offset(-20)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        
    }
    
    //懒加载并初始化视图
    private lazy var tipLabel: UILabel = UILabel(title: "下拉刷新", color: UIColor.darkGrayColor(), fontSize: 14)
    private lazy var arrowImage: UIImageView = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    private lazy var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var scrollView: UIScrollView?
}
