//
//  UIView+Gesture.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/9.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension UIView {

    func yy_addPanGesture(target: Any, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(pan)
    }
    
    func yy_addTapGesture(target: Any, numberOfTapsRequired: Int, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = numberOfTapsRequired
        self.addGestureRecognizer(tap)
    }
    func yy_addSwipeGesture(target: Any, action: Selector) {
        let tap = UISwipeGestureRecognizer(target: target, action: action)
        tap.direction = .down
        self.addGestureRecognizer(tap)
    }
    
}

