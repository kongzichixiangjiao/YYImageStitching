//
//  UIView+Layout.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/29.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension UIView {
    
    func yy_addConstraint(toItem: UIView, top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0, multiplier: CGFloat = 1) {
        guard let subView: UIView = self.superview else {
            print("yy_addConstraint 没有父视图怎么添加约束？")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        subView.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: multiplier, constant: top))
        subView.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: multiplier, constant: bottom))
        subView.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: multiplier, constant: left))
        subView.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: multiplier, constant: right))
    }
    
}
