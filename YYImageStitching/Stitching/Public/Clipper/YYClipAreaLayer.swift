//
//  YYClipAreaLayer.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/23.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYClipAreaLayer: CAShapeLayer {

    private let kLineWidth: CGFloat = 3
    
    var left: CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    var right: CGFloat = 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    var top: CGFloat = SCREEN_WIDTH - 50 {
        didSet {
            setNeedsDisplay()
        }
    }
    var bottom: CGFloat = 400 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lHeight: CGFloat = 200 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lWidth: CGFloat = 200 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lX: CGFloat = 20 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var lY: CGFloat = 20 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func setCropArea(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.lX = x
        self.lY = y
        self.lWidth = w
        self.lHeight = h
        
        setNeedsDisplay()
    }
    
    func setCropArea(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
        setNeedsDisplay()
    }
    
    override func draw(in ctx: CGContext) {
//        let context = UIGraphicsGetCurrentContext()
//        
//        context?.setStrokeColor(UIColor.red.cgColor)
//        context?.addLines(between: [CGPoint(x: 10, y: 10), CGPoint(x: 50, y: 50), CGPoint(x: 50, y: 100), CGPoint(x: 10, y: 100)])
//        context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 2)
//        context?.strokePath()

//        context?.setStrokeColor(UIColor.red.cgColor)
//        context?.setLineWidth(kLineWidth)
//        context?.move(to: CGPoint(x: lX, y: lY))
//        context?.addLine(to: CGPoint(x: lWidth, y: lY))
//        context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 2)
//        context?.strokePath()
//
//        context?.setStrokeColor(UIColor.red.cgColor)
//        context?.setLineWidth(kLineWidth)
//        context?.move(to: CGPoint(x: lWidth, y: lY))
//        context?.addLine(to: CGPoint(x: lWidth, y: lHeight))
//        context?.setShadow(offset: CGSize(width: -0, height: 0), blur: 2)
//        context?.strokePath()
//
//        context?.setStrokeColor(UIColor.white.cgColor)
//        context?.setLineWidth(kLineWidth)
//        context?.move(to: CGPoint(x: lX, y: lHeight))
//        context?.addLine(to: CGPoint(x: lWidth - 100, y: lHeight))
//        context?.setShadow(offset: CGSize(width: 0, height: -0), blur: 2)
//        context?.strokePath()
        
        UIGraphicsPopContext()
        /*
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(kLineWidth)
        context?.move(to: CGPoint(x: left, y: top))
        context?.addLine(to: CGPoint(x: left, y: bottom))
        context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 2)
        context?.strokePath()
        
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(kLineWidth)
        context?.move(to: CGPoint(x: left, y: top))
        context?.addLine(to: CGPoint(x: right, y: top))
        context?.setShadow(offset: CGSize(width: 0, height: 0), blur: 2)
        context?.strokePath()
        
        context?.setStrokeColor(UIColor.red.cgColor)
        context?.setLineWidth(kLineWidth)
        context?.move(to: CGPoint(x: right, y: top))
        context?.addLine(to: CGPoint(x: right, y: bottom))
        context?.setShadow(offset: CGSize(width: -0, height: 0), blur: 2)
        context?.strokePath()
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setLineWidth(kLineWidth)
        context?.move(to: CGPoint(x: left, y: bottom))
        context?.addLine(to: CGPoint(x: right, y: bottom))
        context?.setShadow(offset: CGSize(width: 0, height: -0), blur: 2)
        context?.strokePath()
        
        UIGraphicsPopContext()
 */
    }
    
}

























