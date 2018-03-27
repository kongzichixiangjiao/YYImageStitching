//
//  YYScaleViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/23.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYScaleViewController: YYPickerImageViewController {
    
    var model: YYImageModel! {
        didSet {
        }
    }

    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: self.view.bounds)
        v.delegate = self
        v.minimumZoomScale = 0.1
        v.maximumZoomScale = 3
        v.zoomScale = 3
        v.backgroundColor = UIColor.orange
        self.view.addSubview(v)
        return v
    }()
    
    lazy var imgView: UIImageView = {
        let v = UIImageView(frame: self.view.bounds)
        v.image = UIImage(named: "5.jpg")
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.addSubview(imgView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYScaleViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imgView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.imgView.center = scrollView.center
    }
    
}
