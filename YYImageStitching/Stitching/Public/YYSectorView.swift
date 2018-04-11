//
//  YYSectorView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/10.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYSectorView: UIView {

    var angle: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        let borderW: CGFloat = 1
        let w: CGFloat = rect.size.width - 10
        let h: CGFloat = rect.size.height - 10
        let r: CGFloat = w / 2
        let center: CGPoint = CGPoint(x: w / 2, y: h / 2)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: center)
        context?.addLine(to: CGPoint(x: w / 2 - r * CGFloat(sin(Double.pi / 3)), y: h / 2 - r * CGFloat(cos(Double.pi / 3))))
        context?.addArc(tangent1End: CGPoint(x: w, y: 0), tangent2End: CGPoint(x: w / 2, y: h / 2), radius: r)
        context?.addLine(to: center)
        context?.closePath()
        
        context?.setFillColor(UIColor.yellow.cgColor)
        context?.fillPath()
        
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(borderW)
        context?.strokePath()
        context?.drawPath(using: .fillStroke)
    }

}
