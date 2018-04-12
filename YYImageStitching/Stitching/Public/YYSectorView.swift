//
//  YYSectorView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/10.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYSectorView: UIView {
    var isNei: Bool = false
    var stop: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(frame: CGRect, isNei: Bool = false) {
        self.init(frame: frame)
        
        let w: CGFloat = frame.size.width
        var wais = ["wai_top", "wai_left", "wai_bottom", "wai_right"]
        var waiH: CGFloat = 92
        if isNei {
            wais = ["nei_top", "nei_left", "nei_bottom", "nei_right"]
            waiH = 71
        } else {
            
        }
        
        let wai = UIImageView(image: UIImage(named: wais[0]))
        wai.backgroundColor = UIColor.clear
        wai.frame = CGRect(x: 0, y: 0, width: w, height: waiH)
        self.addSubview(wai)
        
        let waiL = UIImageView(image: UIImage(named: wais[3]))
        waiL.backgroundColor = UIColor.clear
        waiL.frame = CGRect(x: w - waiH, y: 0, width: waiH, height: w)
        self.addSubview(waiL)
        
        let waiB = UIImageView(image: UIImage(named: wais[2]))
        waiB.backgroundColor = UIColor.clear
        waiB.frame = CGRect(x: 0, y: w - waiH, width: w, height: waiH)
        self.addSubview(waiB)
        
        let waiR = UIImageView(image: UIImage(named: wais[1]))
        waiR.backgroundColor = UIColor.clear
        waiR.frame = CGRect(x: 0, y: 0, width: waiH, height: w)
        self.addSubview(waiR)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var angle: CGFloat = 0
    var time: Double = 0
    var velocity: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        return
        
        let borderW: CGFloat = 1
        let w: CGFloat = rect.size.width
        let h: CGFloat = rect.size.height
        let r: CGFloat = w / 2
        let center: CGPoint = CGPoint(x: w / 2, y: h / 2)
        
        for i in 0..<5 {
            let color = UIColor.randomColor()
            color.set()
            let aPath = UIBezierPath(arcCenter: center, radius: r, startAngle: 2 * CGFloat.pi * CGFloat(i) * 1 / 5, endAngle: 2 * CGFloat.pi * CGFloat(i  + 1) * 1 / 5, clockwise: true)
            aPath.addLine(to: center)
            aPath.close()
            aPath.lineWidth = 1.0
            aPath.fill()
        }
    }
    
    @objc func pan(sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let v = sender.velocity(in: self)
            print(v.y)
            if (v.y > 0) {
                print("向上")
                
            } else {
                print("向上")
            }
            velocity += v.y
        }
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        stop = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        stop = false 
    }
    
}

