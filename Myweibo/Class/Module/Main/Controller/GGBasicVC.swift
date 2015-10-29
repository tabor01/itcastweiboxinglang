//
//  GGBasicVC.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGBasicVC: UITableViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//    }

    let userLogin = false
    override func loadView() {
        userLogin ? super.loadView() : setupVisableView()
//        super.loadView()
//        view.backgroundColor = UIColor.brownColor()
//        setupVisableView()
        
    }
    
    
    private func setupVisableView(){
     
       let vistorView = GGVistorView()
        view = vistorView
//        view.backgroundColor = UIColor(white: 237/255.0, alpha: 1)

//        view.backgroundColor = UIColor.whiteColor()
        
        
        if self is GGHomeTableVC
        {
            vistorView.rotationHomeImage()
        }
        else if self is GGMessageTableVC
        {
            vistorView.setupMessage("登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", iconName: "visitordiscover_image_message")
        }
        else if self is GGDiscoverTableVC
        {
            vistorView.setupMessage("登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", iconName: "visitordiscover_image_message")
        }
        else if self is GGProfileTableVC
        {
            vistorView.setupMessage("登录后，你的微博、相册、个人资料会显示在这里，展示给别人", iconName: "visitordiscover_image_profile")
        }
        vistorView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorViewRegisteButtonClick")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: "vistorViewLoginButtonClick")
    }
    
    
//    func setupMessage(message:String,iconName:String)
//    {
//        
//    
//    
//    }

}
extension GGBasicVC:GGVistorViewDelegate{

    func vistorViewLoginButtonClick() {
        print(__FUNCTION__)
    }
    func vistorViewRegisteButtonClick() {
        print(__FUNCTION__)
    }


}
