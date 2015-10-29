//
//  GGTabBar.swift
//  GG.weibo.com
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGTabBar: UITabBar {
    
    private let count: CGFloat = 5
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = bounds.width/count
        
//        let frame = CGRectMake(0, 0, width, bounds.height)
//        CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        let frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
        
//        var index = 0
//        
//        for view in subviews
//        {
//            
//            if view is UIControl && !(view is UIButton)
//            {
//                print("view is \(view)")
////                if index == 2 {
////                    
////                    index++
////                    continue
////                }
//                view.frame = CGRectOffset(frame, width*CGFloat(index), 0)
////                index += index == 1 ? 1 : 1
//                index++
//               
//              
//                
//            }
//            
//        }
        
        composeButton.frame = CGRectOffset(frame, width * 2.0, 0)
    }
    
        lazy var composeButton:UIButton = {
        let composeBtn = UIButton()
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        composeBtn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        composeBtn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        self.addSubview(composeBtn)
        return composeBtn
    }()
    
    
    
}
