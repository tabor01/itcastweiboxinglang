//
//  GGCollectionVC.swift
//  Myweibo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GGCollectionVC: UICollectionViewController {
    
    private let itemCount = 4
    
    private var layout = UICollectionViewFlowLayout()
    
    init(){
        super.init(collectionViewLayout: layout)

    
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
//                view.backgroundColor = UIColor.brownColor()
        // Register cell classes
        self.collectionView!.registerClass(GGCollectCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.prepareLayout()
        // Do any additional setup after loading the view.
    }
    
    func prepareLayout(){
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GGCollectCell
        
        // Configure the cell
        cell.imageIndex = indexPath.item
        cell.pageView.currentPage = indexPath.item
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let showIndexPath = collectionView.indexPathsForVisibleItems().first!
        let cell = collectionView.cellForItemAtIndexPath(showIndexPath) as! GGCollectCell
        
        if showIndexPath.item == itemCount - 1 {
            
            cell.startButtonAnimation()
        }
    }
    
}
class GGCollectCell: UICollectionViewCell {
    
    var imageIndex: Int = 0
        {
            didSet{
                bgImageView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
                startButton.hidden = true
            }
    
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.prepareUI()
    }


    func startButtonAnimation(){
        startButton.hidden = false
        startButton.transform = CGAffineTransformMakeScale(0, 0)
        
        UIView.animateWithDuration(2, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startButton.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                 (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootVC(true)
        }
    }
    
    private func prepareUI(){
        
        contentView.addSubview(bgImageView)
        contentView.addSubview(startButton)
        contentView.addSubview(pageView)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        //        backgroundView.addConstraints(NSLayoutConstraint)
        bgImageView.ff_AlignInner(type: ff_AlignType.CenterCenter, referView: contentView, size: contentView.bounds.size)
        startButton.ff_AlignInner(type: ff_AlignType.BottomCenter, referView: bgImageView, size: nil,
            offset: CGPoint(x: 0, y: -160))
        pageView.ff_AlignVertical(type: ff_AlignType.BottomCenter, referView: startButton, size: nil,offset: CGPoint(x: 0, y: 8))
    }
    
    func startButtonClick(){
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootVC(true)
        
    }
    
    private lazy var pageView: UIPageControl = {
            let pv = UIPageControl()
//        pv.backgroundColor = UIColor.redColor()
        pv.currentPageIndicatorTintColor = UIColor.redColor()
        pv.pageIndicatorTintColor = UIColor.yellowColor()
        pv.numberOfPages = 4
        return pv
        }()
    
    private lazy var bgImageView = UIImageView()
    
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.setTitle("开始体验", forState: UIControlState.Normal)
        
        btn.addTarget(self, action: "startButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    
}
