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
    
    lazy var imgView: UIImageView = {
        let v = UIImageView(frame: self.bounds)
        v.image = UIImage(named: "img_default.jpg")
        v.isUserInteractionEnabled = false
        return v
    }()
    
    var model: YYImageModel! {
        didSet {
            imgView.image = model.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initViews()
    }
    
    func initViews() {
        self.contentView.addSubview(scrollView)
        self.scrollView.addSubview(imgView)
    }

}

extension YYScaleMovingCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.imgView.center = self.center
    }
    
}
