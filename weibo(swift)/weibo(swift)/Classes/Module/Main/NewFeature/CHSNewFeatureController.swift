//
//  CHSNewFeatureController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/16.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class CHSNewFeatureController: UICollectionViewController {

    //设置新特性的图片数量
    let imageCount = 4
    
    //重写init方法,流水布局
    init() {
        
        let layout = UICollectionViewFlowLayout()
        //设置每个Item的大小
        layout.itemSize = UIScreen.mainScreen().bounds.size
        //设置滑动方向
        layout.scrollDirection = .Horizontal
        //设置每个Item的间距为0
        layout.minimumLineSpacing = 0
        //将collection通过布局初始化
        super.init(collectionViewLayout: layout)
        //为collectionview设置分页效果
        collectionView?.pagingEnabled = true
        //取消弹簧效果
        collectionView?.bounces = false
        //不让滚动条显示
        collectionView?.showsHorizontalScrollIndicator = false
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(newFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageCount
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! newFeatureCell
    
        // Configure the cell
        cell.index = indexPath.item + 1
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        //当第三张图完全移动好后,再显示进入按钮
        let cell = collectionView.visibleCells().last as! newFeatureCell
        //获取索引,indexpath的方法返回的是indexpath的结构体
        let index = collectionView.indexPathForCell(cell)?.item
        //动画在最后一页现实好后出现按钮
        if index == imageCount - 1 {
            cell.showAnimation()
        }
    }

}





//自定义cell
class newFeatureCell: UICollectionViewCell {

    
    //设置一个index用来换图
    var index: Int = 0 {
        didSet{
            cellImage.image = UIImage(named: "new_feature_\(index)")
            //将按钮在不用的时候隐藏起来
            enterBtn.hidden = true
        }
    
    
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置布局
        newFeatureCellLayout()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    //设置cell布局
    private func newFeatureCellLayout() {
        addSubview(cellImage)
        addSubview(enterBtn)
        
        //添加图片的约束
        cellImage.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
        
        //添加按钮的约束
        enterBtn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(contentView.snp_bottom).offset(-180)
            make.centerX.equalTo(contentView.snp_centerX)
        }
        
        //添加按钮的点击事件
        enterBtn.addTarget(self, action: "enterBtnClicking", forControlEvents: .TouchUpInside)
        
    }
    
    //进入按钮的点击事件
    func enterBtnClicking() {
        print("进入按钮被点击了")
        NSNotificationCenter.defaultCenter().postNotificationName(changeRootViewController, object: nil)
    }
    
    
    //按钮出现的动画
    func showAnimation() {
        enterBtn.hidden = false
        //动画开始前修改transform
        enterBtn.transform = CGAffineTransformMakeScale(0, 0)
        //设置动画
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: { () -> Void in
            self.enterBtn.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                print("进入按钮完成")
        }


    }
    
    
    //初始化图片
    lazy var cellImage: UIImageView = UIImageView(image: UIImage(named: "new_feature_1"))
    //初始化开始按钮
    lazy var enterBtn: UIButton = UIButton(title: "开始体验", titleColor: UIColor.whiteColor(), backImage: "new_feature_finish_button")

}

