//
//  GGWelcomVC.swift
//  Myweibo
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit
import SDWebImage
class GGWelcomVC: UIViewController {

    private var iconViewBottomCon: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareUI()
        view.backgroundColor = UIColor.brownColor()
        if let urlString = GGUserAccount.loadAccount()?.avatar_large {
            iconView.sd_setImageWithURL(NSURL(string: urlString),placeholderImage: UIImage(named: "avatar_default_big"))
        
        }
       
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //开始动画
        iconViewBottomCon?.constant = -(UIScreen.mainScreen().bounds.height-160)
        
//        UIView.animateWithDuration(2, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
//            self.view.layoutIfNeeded()
//            
//            UIView.animateWithDuration(1, animations: { () -> Void in
//                self.welcomeLabel.alpha = 1
//            })
//            
//            }) { (_) -> Void in
////                (UIApplication.sharedApplication().delegate as! AppDelegate).switchRootVC(true)
//        }
        
        UIView.animateWithDuration(2, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.welcomeLabel.alpha = 1
                    }, completion: { (_) -> Void in
                        print("------")
                       ( UIApplication.sharedApplication().delegate as! AppDelegate).switchRootVC(true)
                })
        }
        
        
    }
    
    
    
    
    private func prepareUI(){
        //添加子控件
        view.addSubview(backGroundImageView)
        view.addSubview(iconView)
        view.addSubview(welcomeLabel)
        
        //关闭 系统自动布局子控件
        backGroundImageView.translatesAutoresizingMaskIntoConstraints = false
        iconView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //添加约束
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bg":backGroundImageView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[bg]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["bg":backGroundImageView]))
        
        let cons = iconView.ff_AlignInner(type: ff_AlignType.BottomCenter, referView: backGroundImageView, size: CGSize(width: 85, height: 85), offset: CGPoint(x: 0, y: -160))
        iconViewBottomCon = iconView.ff_Constraint(cons, attribute: NSLayoutAttribute.Bottom)
        
        welcomeLabel.ff_AlignVertical(type: ff_AlignType.BottomCenter, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 16))
        
    }


    private lazy var backGroundImageView:UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default_big"))
        imageView.layer.cornerRadius = 42.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var welcomeLabel:UILabel = {
        let label = UILabel()
        
        let name = GGUserAccount.loadAccount()?.name ?? ""
        label.text = "\(name),欢迎归来！"
        label.alpha = 0
        return label
    }()
}
