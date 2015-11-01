//
//  GGHomeTabBarController.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/26.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGHomeTableVC: GGBasicVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GGUserAccount.userLogin() == false
        { return
        }
        self.setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendsearch")
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        
    }
    
    
}
