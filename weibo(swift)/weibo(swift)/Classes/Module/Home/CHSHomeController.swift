//
//  CHSHomeController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/15.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

class CHSHomeController: CHSBaseViewController {

    let userAccount = CHSUserAccountViewModel().userAccount
    //存储状态的集合
    lazy var statuses = [CHSStatus]()
    //cell的重用标识
    private let ID = "statusCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !userLogIn {
            guestView?.setInfoAndImage("关注一些人，回这里看看有什么惊喜", imageNmae: nil)
            return
        }
        //获取微博信息
        loadStatuses()
        
        //注册tableView的cell
        tableView.registerClass(CHSStatusCell.self, forCellReuseIdentifier: ID)
        
        //设置tableView的行高
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight = 200
        //将tableView的分割线去掉
        tableView.separatorStyle = .None
        
        //添加系统的下拉刷新
//        refreshControl = UIRefreshControl()
//        refreshControl?.addTarget(self, action: "loadStatuses", forControlEvents: .ValueChanged)
        //添加页面最后的加载更多视图
        tableView.tableFooterView = indicatorView
        
        //添加刷新的View
        tableView.addSubview(refreshView)
        refreshView.addTarget(self, action: "loadStatuses", forControlEvents: .ValueChanged)
        
    }

    func loadStatuses() {
        //since_id和max_id是用来获取最新微博和加载更多微博的
        var max_id: Int64 = 0
        var since_id: Int64 = 0
        if indicatorView.isAnimating() {
            max_id = self.statuses.last?.id ?? 0
        } else {
            since_id = self.statuses.first?.id ?? 0
        }
        
        
        
        CHSStatusesViewModel.loadHomeControllerData(since_id, max_id: max_id) { (status) -> () in

            if since_id != 0 {
                self.statuses = status + self.statuses
                //结束菊花刷新
//                self.refreshControl?.endRefreshing()
                self.refreshView.endRefresh()
            } else if max_id != 0 {
                
                self.statuses = self.statuses + status
                self.indicatorView.stopAnimating()
                
            } else {
                
                self.statuses = status
            }

            
            
            
            //刷新表视图
            self.tableView.reloadData()
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statuses.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! CHSStatusCell

        //给cell赋值
        cell.status = statuses[indexPath.row]
        
        //加载最后cell的时候转动菊花
        if indexPath.row == statuses.count - 1 {
            indicatorView.startAnimating()
            //加载状态
            loadStatuses()
        }

        return cell
    }

    //懒加载并初始化视图
    private lazy var refreshView: CHSRefreshViewController = CHSRefreshViewController()
    private lazy var indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
}
