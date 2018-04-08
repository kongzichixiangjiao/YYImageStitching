//
//  YYClipBorderView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYClipBorderView: UIView {
    public var borderColor: UIColor = UIColor.orange {
        didSet {
            
            self.setNeedsDisplay()
        }
    }
    
    public var space: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let strokeRect = rect
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.borderColor.cgColor)
        context?.stroke(strokeRect, width: self.space)
        context?.drawPath(using: .stroke)
    }

}
