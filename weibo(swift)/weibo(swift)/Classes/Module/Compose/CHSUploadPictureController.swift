//
//  CHSUploadPictureController.swift
//  weibo(swift)
//
//  Created by 王 on 15/12/29.
//  Copyright © 2015年 王. All rights reserved.
//

import UIKit
import SnapKit

private let reuseIdentifier = "uploadPicture"
private let itemMargin: CGFloat = 5

class CHSUploadPictureController: UICollectionViewController {
    
    //定义一个存放图片的数组
    var pictureArr = [UIImage]()
    
    //初始化上传图片的控制器
    init() {
        
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        
        let w = (view.frame.width - 4 * itemMargin) / 3
        layout.itemSize = CGSize(width: w, height: w)
        
        layout.minimumInteritemSpacing = itemMargin
        layout.minimumLineSpacing = itemMargin
        layout.sectionInset = UIEdgeInsetsMake(itemMargin, itemMargin, 0, itemMargin)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(CHSSelectorCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pictureArr.count + 1
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CHSSelectorCell
    
        cell.delegate = self
        
        if indexPath.item == pictureArr.count {
            cell.image = nil
            cell.deleteBtn.hidden = true
        } else {
            print(pictureArr[indexPath.item],indexPath.item)
            cell.image = pictureArr[indexPath.item]
            cell.deleteBtn.hidden = false
        }
        
        cell.backgroundColor = randomColor()
        // Configure the cell
    
        return cell
    }

    

}

extension CHSUploadPictureController: selectorCellDelegate {
    func addImage(cell: CHSSelectorCell) {
        if cell.image != nil {
            return
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        presentViewController(picker, animated: true) { () -> Void in
            print("OK")
        }
    }
    func deleteImage(cell: CHSSelectorCell) {
           print("删除按钮被点击了")
        if let indexPath = collectionView?.indexPathForCell(cell) {
            pictureArr.removeAtIndex(indexPath.item)
            collectionView?.reloadData()
            
        }
        
    }
}

extension CHSUploadPictureController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print(image)
        pictureArr.append(image)
        dismissViewControllerAnimated(true, completion: nil)
        collectionView?.reloadData()
    }
}





//设置添加删除按钮的回调协议
@objc protocol selectorCellDelegate: NSObjectProtocol {
    func addImage(cell: CHSSelectorCell)
    func deleteImage(cell: CHSSelectorCell)
}

//自定义cell
class CHSSelectorCell: UICollectionViewCell {
    
    //设置cellImage的属性
    var image: UIImage? {
        didSet {
            addBtn.setImage(image, forState: .Normal)
            addBtn.imageView?.contentMode = .ScaleAspectFill
        }
    }
    
    //设置代理属性
    weak var delegate: selectorCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置布局
        decorateUI()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func decorateUI() {
        //添加子视图
        contentView.addSubview(addBtn)
        contentView.addSubview(deleteBtn)
        
        
        //添加约束
        addBtn.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(contentView.snp_edges)
        }
        deleteBtn.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(contentView)
        }
        
        //按钮的点击事件
        addBtn.addTarget(self, action: "addBtnClicking", forControlEvents: .TouchUpInside)
        deleteBtn.addTarget(self, action: "deleteBtnClicking", forControlEvents: .TouchUpInside)
        
    }
    
    //按钮的点击事件
    func addBtnClicking() {
        delegate?.addImage(self)
        
    }
    func deleteBtnClicking() {
        print("删除按钮被点击了")
        delegate?.deleteImage(self)
    }
    
    
    
    //懒加载视图空间
    private lazy var addBtn: UIButton = UIButton(backImage: "compose_pic_add", backImageHighlight: "compose_pic_add_highlight")
//    private lazy var addBtn: UIButton = UIButton(image: "compose_pic_add", imageHighlight: "compose_pic_add_highlighted")
    private lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "compose_photo_close"), forState: .Normal)
        
        return btn
    }()
    
}















