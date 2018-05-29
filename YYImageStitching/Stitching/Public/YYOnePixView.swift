//
//  YYOnePixView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  分割线

import UIKit

@IBDesignable
class YYOnePixView: UIView {

//    @IBInspectable var onePix: Bool! = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
       mySetOnePixView()
    }
    
    func mySetOnePixView() {
        
        if (1 == 1) {
            for layout in self.constraints {
                if (layout.firstItem as! NSObject == self && (layout.firstAttribute == NSLayoutAttribute.width || layout.firstAttribute == NSLayoutAttribute.height)) {
                    if (layout.constant == 1) {
                        layout.constant = 1.0 / UIScreen.main.scale
                    }
                }
            }
        }
    }
}


