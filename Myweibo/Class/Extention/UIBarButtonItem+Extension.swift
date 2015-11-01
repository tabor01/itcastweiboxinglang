//
//  UIBarButtonItem+Extension.swift
//  Myweibo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    
    convenience init(imageName:String) {
        
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
        button.sizeToFit()
        self.init(customView: button)
    }
    
    

    private class func navigationItem(imageName: String)->UIBarButtonItem{
        let button = UIButton()
        button.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "\(imageName)_highlighted"), forState: UIControlState.Highlighted)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }


}
