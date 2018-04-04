//
//  YYProgressView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/29.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

private let kProgressViewHeight: CGFloat = 8

class YYProgressView: UIControl {
    
    public var progressColor: UIColor = UIColor.orange {
        didSet {
            let w: CGFloat = self.currentPointX - self.space
            up.backgroundColor = w <= 0 ? UIColor.red : progressColor
        }
    }
    
    typealias YYProgressViewHandler = (_ width: CGFloat, _ type: YYClipViewSpaceType) -> ()
    var progressViewHandler: YYProgressViewHandler?
    
    private let space: CGFloat = 20
    private var currentPointX: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViews()
    }
    
    func initViews() {
        self.backgroundColor = UIColor.clear
        self.addSubview(back)
        self.addSubview(up)
    }
    
    lazy var back: YYProgressBackView = {
        let back = YYProgressBackView(frame: frame)
        back.frame = self.bounds
        return back
    }()
    
    
    lazy var up: YYProgressUpView = {
        let up = YYProgressUpView(frame: CGRect(x: 20, y: 0, width: 2, height: kProgressViewHeight))
        up.backgroundColor = self.progressColor
        return up
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchesAllAction(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        touchesAllAction(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchesAllAction(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesAllAction(touches, with: event)
    }
    
    private func touchesAllAction(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let point = touch.location(in: self)
        currentPointX = point.x
        if currentPointX > 0 && currentPointX < self.frame.size.width {
            let w: CGFloat = point.x - space
            up.frame = CGRect(x: space, y: 0, width: w, height: kProgressViewHeight)
            up.backgroundColor = w <= 0 ? UIColor.red : progressColor
            progressViewHandler!(w <= 0 ? 0 : w, .add)
        }
    }
    
}

class YYProgressUpView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        /*
        return
        let borderW: CGFloat = 1
        let oldW: CGFloat = rect.size.width
        let oldH: CGFloat = rect.size.height
        let newRect = CGRect(x: borderW, y: borderW, width: oldW - borderW * 2, height: oldH - borderW * 2)
        let w: CGFloat = newRect.size.width
        let h: CGFloat = kProgressViewHeight
        let r: CGFloat = h / 2 + borderW
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: r, y: borderW))
        context?.addLine(to: CGPoint(x: w - r, y: borderW))
        context?.addArc(tangent1End: CGPoint(x: w, y: borderW), tangent2End: CGPoint(x: w, y: h / 2), radius: r)
        context?.addArc(tangent1End: CGPoint(x: w, y: h), tangent2End: CGPoint(x: w - r, y: h), radius: r)
        context?.addLine(to: CGPoint(x: r, y: h))
        context?.addArc(tangent1End: CGPoint(x: borderW, y: h), tangent2End: CGPoint(x: borderW, y: h / 2), radius: r)
        context?.addArc(tangent1End: CGPoint(x: borderW, y: borderW), tangent2End: CGPoint(x: r, y: borderW), radius: r)
        context?.closePath()
        
        context?.setFillColor(UIColor.orange.cgColor)
        context?.fillPath()
        
        context?.setStrokeColor(UIColor.orange.cgColor)
        context?.setLineWidth(borderW)
        context?.strokePath()
        context?.drawPath(using: .fillStroke)
         */
    }
}

class YYProgressBackView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let borderW: CGFloat = 1
        let oldW: CGFloat = rect.size.width
        let oldH: CGFloat = rect.size.height
        let newRect = CGRect(x: borderW, y: borderW, width: oldW - borderW * 2, height: oldH - borderW * 2)
        let w: CGFloat = newRect.size.width
        let h: CGFloat = kProgressViewHeight
        let r: CGFloat = h / 2 + borderW
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: r, y: borderW))
        context?.addLine(to: CGPoint(x: w - r, y: borderW))
        context?.addArc(tangent1End: CGPoint(x: w, y: borderW), tangent2End: CGPoint(x: w, y: h / 2), radius: r)
        context?.addArc(tangent1End: CGPoint(x: w, y: h), tangent2End: CGPoint(x: w - r, y: h), radius: r)
        context?.addLine(to: CGPoint(x: r, y: h))
        context?.addArc(tangent1End: CGPoint(x: borderW, y: h), tangent2End: CGPoint(x: borderW, y: h / 2), radius: r)
        context?.addArc(tangent1End: CGPoint(x: borderW, y: borderW), tangent2End: CGPoint(x: r, y: borderW), radius: r)
        context?.closePath()
        
        context?.setFillColor(UIColor.yellow.cgColor)
        context?.fillPath()
        
        context?.setStrokeColor(UIColor.orange.cgColor)
        context?.setLineWidth(borderW)
        context?.strokePath()
        context?.drawPath(using: .fillStroke)
    }
}

