//
//  YYClipView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum YYClipViewSpaceType: Int {
    case add = 0, subtraction = 1
}

class YYClipView: UIView {

    public var space: CGFloat = 0
    public var borderColor: UIColor = UIColor.white {
        didSet {
            self.borderView.borderColor = borderColor
            self.setNeedsDisplay()
        }
    }
    
    var image: UIImage? {
        didSet {
//            self.addSubview(scrollView)
//            scrollView.addSubview(imageView)
            self.imageView.image = image
            self.addSubview(imageView)
            self.addSubview(borderView)
        }
    }
    
    lazy var imageView: YYClipImageView = {
        let v = YYClipImageView(frame: self.bounds)
        return v
    }()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height ))
        v.delegate = self
        v.minimumZoomScale = 0.5
        v.maximumZoomScale = 3
        v.zoomScale = 1
        v.backgroundColor = UIColor.white
        return v
    }()
    
    lazy var borderView: YYClipBorderView = {
        let v = YYClipBorderView(frame: self.bounds)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func adjustSpace(space: CGFloat, type: YYClipViewSpaceType) {
        switch type {
        case .add:
            self.space += space
            self.borderView.space = self.space
            self.setNeedsDisplay()

            break
        case .subtraction:
            self.space -= space
            self.borderView.space = self.space
            self.setNeedsDisplay()

            break
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let strokeRect = rect
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(self.borderColor.cgColor)
        context?.stroke(strokeRect, width: self.space * 2)
        context?.drawPath(using: .stroke)
        return 
        guard let image = self.image else {
            return
        }
        context?.draw(image.cgImage!, in: CGRect(x: self.space, y: self.space, width: rect.width - self.space * 2, height: rect.height - self.space * 2))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
}

extension YYClipView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if self.imageView.frame.size.width > scrollView.frame.size.width {
            if (self.imageView.frame.size.height < scrollView.contentSize.height) {
                self.imageView.center = CGPoint(x: scrollView.contentSize.width / 2, y: scrollView.contentSize.height / 2)
            } else {
                self.imageView.center = CGPoint(x: scrollView.contentSize.width / 2, y: scrollView.center.y)
            }
        } else {
            self.imageView.center = CGPoint(x: self.scrollView.center.x, y: self.scrollView.center.y)
        }
    }
}
