//
//  YYSectorView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/10.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYSectorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        yy_addSwipeGesture(target: self, action: #selector(swipe(sender:)))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var angle: CGFloat = 0
    var time: Double = 0
    override func draw(_ rect: CGRect) {
        let borderW: CGFloat = 1
        let w: CGFloat = rect.size.width
        let h: CGFloat = rect.size.height
        let r: CGFloat = w / 2
        let center: CGPoint = CGPoint(x: w / 2, y: h / 2)

        let color = UIColor.randomColor()
        color.set()
        let aPath = UIBezierPath(arcCenter: center, radius: r,
                                 startAngle: CGFloat(0 + time), endAngle: CGFloat(1 + time), clockwise: true)
        aPath.addLine(to: center)
        aPath.close()
        aPath.lineWidth = 1.0
        aPath.fill()
    }
    
    @objc func swipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .began {
            print(sender.direction)
        }
    }
    
  
}
