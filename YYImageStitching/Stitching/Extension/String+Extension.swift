//
//  String+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Foundation
extension String {
    var int64: Int64 {
        return Int64(self) ?? -99999999999
    }
}
// WARK: COLOR
extension String {
    var color0X: UIColor! {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    func color0X(_ alpha: CGFloat) -> UIColor {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }

}
// MARK: xibLoadView()
extension String {
    func xibLoadView() -> UIView {
        return Bundle.main.loadNibNamed(self, owner: nil, options: nil)?.last as! UIView
    }
}

// MARK: toFloat() toDouble()
extension String {
    func toFloat() -> Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.floatValue
    }
    
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.doubleValue
    }
}

// UIStoryboard XIB
extension String {
    func yy_storyboard() -> UIStoryboard {
        return UIStoryboard(name: self, bundle: nil)
    }
    
    func yy_xib() -> UIViewController {
        return UIViewController(nibName: self, bundle: nil)
    }
}


private let kStoryboadName = "Main"
extension UIStoryboard {
    static func yy_main() -> UIStoryboard {
        return UIStoryboard(name: kStoryboadName, bundle: nil)
    }
    
    static func yy_main(vcName: String) -> UIViewController? {
        print("Storyboard ID 设置了吗？")
        let vc = UIStoryboard(name: kStoryboadName, bundle: nil).instantiateViewController(withIdentifier: vcName)
        return vc
    }
    
    static func yy_storyboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
    static func yy_storyboard(name: String, vcName: String) -> UIViewController? {
        print("Storyboard ID 设置了吗？")
        let vc = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: vcName)
        return vc
    }
}
