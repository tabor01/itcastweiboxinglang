//
//  GGHomeTitleButton.swift
//  Myweibo
//
//  Created by apple on 15/11/1.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGHomeTitleButton: UIButton{

    override func layoutSubviews() {
        
        super.layoutSubviews()
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width + 3
        
    }

}