//
//  UIView+Extension.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension UIView {
    func yy_screenshot() -> UIImage? {
        if UIScrollView.classForCoder() == self.classForCoder {
            let scrollView = self as! UIScrollView
            let offset = scrollView.contentOffset
            scrollView.contentOffset = CGPoint.zero
            let frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            
            let img = scrollView.yy_screenshot(size: scrollView.frame.size)
            
            scrollView.contentOffset = offset
            scrollView.frame = frame
            
            return img
        } else {
            if (self.frame.size.height == 0 || self.frame.size.width == 0) {
                return nil 
            }
            return yy_screenshot(size: self.frame.size)
        }
    }
    
    func yy_screenshot(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
//        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
