//
//  UIView+LoadView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
// MARK: Bundle.main.loadNibNamed
extension UIView {
    class func ga_loadView() -> UIView {
        return Bundle.main.loadNibNamed(self.ga_nameOfClass, owner: self, options: nil)?.last as! UIView
    }
    
    class func ga_loadView(count: Int) -> UIView {
        return Bundle.main.loadNibNamed(self.ga_nameOfClass, owner: self, options: nil)?[count] as! UIView
    }
    
}
