//
//  YYScaleMovingCell.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/26.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Photos

class YYScaleMovingCell: UICollectionViewCell {
    
    static let identifier = "YYScaleMovingCell"
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: self.bounds)
        v.delegate = self
        v.minimumZoomScale = 0.5
        v.maximumZoomScale = 2
        v.zoomScale = 3
        v.isUserInteractionEnabled = false
        self.addSubview(v)
        return v
    }()
    
    lazy var imageView: UIImageView = {
        let v = UIImageView(frame: self.bounds)
        v.image = UIImage(named: "img_default.jpg")
        v.isUserInteractionEnabled = true
        return v
    }()
    
    var model: YYImageModel! {
        didSet {
            imageView.image = model.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initViews()
        imageView.yy_addTapGesture(target: self, numberOfTapsRequired: 2, action: #selector(tap(sender:)))
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        print("2")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initViews() {
        /*
         self.contentView.addSubview(scrollView)
         self.scrollView.addSubview(imageView)
        */
        self.contentView.addSubview(imageView)
        imageView.yy_addConstraint(toItem: self.contentView)
    }
    
}

extension YYScaleMovingCell: UIScrollViewDelegate {
    
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

