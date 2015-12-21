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
        
    }

    func loadStatuses() {
        
        CHSStatusesViewModel.loadHomeControllerData { (status) -> () in
            self.statuses = status
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

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
