//
//  GGTabBarMain.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGTabBarMain: UITabBarController {
    
    override func viewDidLoad() {

      let newTB = GGTabBar()
        newTB.composeButton.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        setValue(newTB, forKey: "tabBar")
        
        self.tabBar.tintColor = UIColor.orangeColor()
//        super.viewDidLoad()
        
//        let homeVC = GGHomeTableVC()
//        homeVC.title = "首页"
//        homeVC.tabBarItem.image = UIImage(named: "tabbar_home")
//    homeVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orangeColor()], forState: UIControlState.Selected)
//        
//        homeVC.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//        
//        self.addChildViewController(homeVC)
        
        let homeVC = GGHomeTableVC()
        addController(homeVC, title: "首页", image: "tabbar_home")
//        
//        let disVC = GGDiscoverTableVC()
//        disVC.title = "发现"
//        disVC.tabBarItem.image = UIImage(named: "tabbar_discover")
//        
//        addChildViewController(disVC)
        
        let disVC = GGHomeTableVC()
        addController(disVC, title: "发现", image: "tabbar_discover")
//        
//        
//        let messVC = GGMessageTableVC()
//        messVC.title = "消息"
//        messVC.tabBarItem.image = UIImage(named: "tabbar_message_center")
//        
//        addChildViewController(messVC)
//        
        
        let addVC = GGBasicVC()
        addController(addVC, title: "", image: "f")
        
        let messVC = GGMessageTableVC()
        addController(messVC, title: "消息", image: "tabbar_message_center")
//        
//        let proVC = GGMessageTableVC()
//        proVC.title = "我"
//        proVC.tabBarItem.image = UIImage(named: "tabbar_profile")
//        
//        addChildViewController(proVC)
        let proVC = GGProfileTableVC()
        addController(proVC, title: "我", image: "tabbar_profile")
        
        // Do any additional setup after loading the view.
    }

    private func addController(vc:UIViewController,title:String,image:String){
        
//                let disVC = GGDiscoverTableVC()
                vc.title = title
                vc.tabBarItem.image = UIImage(named: image)
        
                addChildViewController(UINavigationController(rootViewController: vc))
        
    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//    }
//    
//        let width = tabBar.bounds.width/CGFloat(5)
//        composeButton.frame = CGRectMake(width*2, 0, width, tabBar.bounds.height)
//        tabBar.addSubview(composeButton)
    }
    
    
    private lazy var composeButton:UIButton = {
    
        let button = UIButton()
        
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        button.addTarget(self, action: "composeButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
    
        return button
    }()
    
    func composeButtonClick() {
    
        print(__FUNCTION__)
//        __FUNCTION__
    
    }
//




}
