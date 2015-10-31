//
//  GGVistorView.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

protocol GGVistorViewDelegate: NSObjectProtocol{
    
    func vistorViewRegisteButtonClick()
    func vistorViewLoginButtonClick()
    
}


class GGVistorView: UIView {

 
    var userLogin:Bool?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor(white: 237/255.0, alpha: 1)
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loginButtonClick()
    {
        delegate?.vistorViewLoginButtonClick()
    
    }
    func registerButtonClick()
    {
        delegate?.vistorViewRegisteButtonClick()
    }
    
    
    func setupMessage(message:String,iconName:String){
        messageLabel.text = message;
//        messageLabel.sizeToFit()
        iconView.image = UIImage(named: iconName)
        
        homeView.hidden = true
        sendSubviewToBack(coverView)
    }
    
    weak var delegate:GGVistorViewDelegate?
    
   private func prepareUI(){
        
        
        
        addSubview(iconView)
        addSubview(coverView)
        addSubview(homeView)
        addSubview(messageLabel)
        addSubview(registButton)
        addSubview(loginButton)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        homeView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        registButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        coverView.translatesAutoresizingMaskIntoConstraints = false
        //转轮
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -40))
        //小房子
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: homeView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -20))
        //说明文字
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: homeView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 25))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 240))
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        //注册
        addConstraint(NSLayoutConstraint(item: registButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: registButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 100))
        addConstraint(NSLayoutConstraint(item: registButton, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: registButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 35))
        //登陆
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 100))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 20))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: messageLabel, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 0, constant: 35))
    
        //遮罩
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: coverView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: loginButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
    }
    
     func rotationHomeImage(){
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 20
        animation.repeatCount = MAXFLOAT
        
        animation.removedOnCompletion = false
        iconView.layer.addAnimation(animation, forKey: "homeAnimation")
    }
    
    /// 暂停旋转
    func pauseAnimation() {
        // 记录暂停时间
        let pauseTime = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        
        // 设置动画速度为0
        iconView.layer.speed = 0
        print("hhhhhh")
        // 设置动画偏移时间
        iconView.layer.timeOffset = pauseTime
    }
    
    /// 恢复旋转
    func resumeAnimation() {
        // 获取暂停时间
        let pauseTime = iconView.layer.timeOffset
        
        // 设置动画速度为1
        iconView.layer.speed = 1
        
        iconView.layer.timeOffset = 0
        
        iconView.layer.beginTime = 0
        
        let timeSincePause = iconView.layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
         print(iconView.description)
        iconView.layer.beginTime = timeSincePause
    }
    
    private lazy var iconView:UIImageView = {
        let imgView = UIImageView()
        
        let image = UIImage(named: "visitordiscover_feed_image_smallicon")
        imgView.image = image
        
        imgView.sizeToFit()
       
        
        return imgView
    
    }()
    
    private lazy var coverView:UIImageView = {
        let imgView = UIImageView()
        
        let img = UIImage(named: "visitordiscover_feed_mask_smallicon")
    
        imgView.image = img

        return imgView
    
    }()
    
    private lazy var homeView:UIImageView = {
    
        let imgView = UIImageView()
        
        let image = UIImage(named: "visitordiscover_feed_image_house")
        imgView.image = image
        
        imgView.sizeToFit()
        
        return imgView
    }()
    
    private lazy var messageLabel:UILabel = {
        let msgLabel = UILabel()
        msgLabel.text = "关注一些人,看看有什么惊喜"
        msgLabel.textColor = UIColor.lightGrayColor()
        msgLabel.numberOfLines = 0
        msgLabel.sizeToFit()
//        UIColor.lightGrayColor()
        
        return msgLabel
    }()
    
    private lazy var registButton:UIButton = {
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.titleLabel?.text = "注册"
        button.setTitle("注册", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
//        button.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.sizeToFit()
        
        button.addTarget(self, action: "registerButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }()

    private lazy var loginButton:UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "登陆"
        button.setTitle("登陆", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        button.sizeToFit()
        button.addTarget(self, action: "loginButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return button
    }()
    
}


