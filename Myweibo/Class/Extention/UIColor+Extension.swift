//
//  UIColor+Extension.swift
//  Myweibo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

extension UIColor {

    class func randomColor()->UIColor {
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
    }
    
    private class func randomValue()->CGFloat{
        return CGFloat(arc4random_uniform(256))/255
        
    }

}