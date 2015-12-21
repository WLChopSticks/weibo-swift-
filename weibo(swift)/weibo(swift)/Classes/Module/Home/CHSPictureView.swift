//
//  CHSPictureView.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/19.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

//cell的重用标识
let ID = "pictureCell"
let pictureViewMargin: CGFloat = 5

class CHSPictureView: UICollectionView {

    
    //接收数据
    var imageURL: [NSURL]? {
        didSet {
//            print(self.imageURL?.count)
            pictureCount.text = "\(self.imageURL?.count ?? 0)"
            let pictureSize:CGSize = pictureViewSizeWithImages(self.imageURL?.count ?? 0)
            //更新约束
            self.snp_updateConstraints { (make) -> Void in
                make.size.equalTo(pictureSize)
            }
                reloadData()
        }
        
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        //设置pictureview的最小间距
        layout.minimumLineSpacing = pictureViewMargin
        layout.minimumInteritemSpacing = pictureViewMargin
        //注册collectionview的cell
        registerClass(pictureViewCell.self, forCellWithReuseIdentifier: ID)
        //设置数据源
        self.dataSource = self
        
        
        backgroundColor = UIColor.yellowColor()
        
        
        
        //添加label
        addSubview(pictureCount)
        pictureCount.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.snp_center)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置pictureview的宽,根据图片数量
    func pictureViewSizeWithImages(imageCount: Int) -> CGSize {
        
        let pictureWidth: CGFloat = (screenWidth - 2 * pictureViewMargin - 2 * statusCellMargin) / 3
        //取出流水布局
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(pictureWidth, pictureWidth)
        
        switch imageCount {
        case 0: return CGSizeZero
        case 1:
            let size = CGSizeMake(100, 100)
            layout.itemSize = size
            return size
        case 4: //定义状态的图片宽度
            let pictureSize: CGSize = CGSizeMake(2 * pictureWidth + 1 * pictureViewMargin, 2 * pictureWidth + 1 * pictureViewMargin)
            return pictureSize
        default:
            let pictureViewHeightCount: CGFloat = CGFloat((imageCount - 1) / 3 + 1)
            let pictureSize: CGSize = CGSizeMake(3 * pictureWidth + 2 * pictureViewMargin, pictureViewHeightCount * pictureWidth + CGFloat(pictureViewHeightCount - 1) * pictureViewMargin)
            return pictureSize
            
        }
        
    }
    
    //懒加载视图
    lazy var pictureCount: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.redColor()
        
        return label
        
    }()

}



extension CHSPictureView: UICollectionViewDataSource {
    
    //添加collectionView的cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURL?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ID, forIndexPath: indexPath) as! pictureViewCell
//        cell.backgroundColor = randomColor()
        cell.imageURL = imageURL![indexPath.row]
        print(imageURL![indexPath.row])
        
        return cell
    }

}


//自定义cell
class pictureViewCell: UICollectionViewCell {
    
    //获取图片的url,为图片赋值
    var imageURL: NSURL? {
        didSet {
            print(imageURL)
            pictureCell.sd_setImageWithURL(imageURL)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        decorateUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decorateUI() {
        contentView.addSubview(pictureCell)
        pictureCell.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp_edges)
        }
    }

    //懒加载并初始化视图
    lazy var pictureCell: UIImageView = {
        let image = UIImageView()
        //将图片的显示编程不失真,但是截取的
        image.contentMode = UIViewContentMode.ScaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    
}
