//
//  UIColor+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension UIColor {
    static func randomCGColor(alpha a: CGFloat = 1) -> CGColor {
        return self.randomColor(a).cgColor
    }
    
    static func randomColor(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: alpha)
    }
    
    static func rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255,
                            green: g / 255,
                            blue: b / 255,
                            alpha: 1.0)
    }
    static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255,
                            green: g / 255,
                            blue: b / 255,
                            alpha: a)
    }
}
