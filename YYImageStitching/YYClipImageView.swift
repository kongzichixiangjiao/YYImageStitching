//
//  YYClipImageView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYClipImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        self.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        self.addGestureRecognizer(pinch)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(rotation(sender:)))
        self.addGestureRecognizer(rotation)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        longPress.minimumPressDuration = 1.5
        self.addGestureRecognizer(longPress)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        tap.numberOfTapsRequired = 2
        self.addGestureRecognizer(tap)
    }
    
    // 移动手势方法
    @objc func pan(sender: UIPanGestureRecognizer) {
        let x: CGFloat = self.center.x
        let y: CGFloat = self.center.y
        let translation = sender.translation(in: self)
        sender.view!.center = CGPoint(x: x + translation.x, y: y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
    }
    // 捏合手势方法
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    // 旋转手势
    @objc func rotation(sender: UIRotationGestureRecognizer) {
        if (sender.state == .changed) {
            
        }
        sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    // 长按手势
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        if (sender.state == .began) {
            print("-longPress-")
        }
    }
    // 点击手势
    @objc func tap(sender: UITapGestureRecognizer) {
        self.transform = CGAffineTransform.identity
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

