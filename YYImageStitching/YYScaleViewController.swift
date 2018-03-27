//
//  YYScaleViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/23.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

private let kNavigationViewBottomSpace: CGFloat = 0
private var kTopSpace: CGFloat = 64
class YYScaleViewController: YYPickerImageViewController {

    var model: YYImageModel! {
        didSet {
        }
    }

    lazy var scrollView: UIScrollView = {
        var insets = UIEdgeInsets.zero
        if UIDevice.current.isX {
            if #available(iOS 11.0, *) {
                insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
                kTopSpace -= kNavigationViewBottomSpace
            }
        }
        let v = UIScrollView(frame: CGRect(x: 0, y: kTopSpace, width: self.view.bounds.width, height: self.view.bounds.height - kTopSpace))
        v.delegate = self
        v.minimumZoomScale = 0.5
        v.maximumZoomScale = 3
        v.zoomScale = 1
        v.backgroundColor = UIColor.white
        return v
    }()
    
    lazy var imgView: UIImageView = {
        var insets = UIEdgeInsets.zero
        if UIDevice.current.isX {
            if #available(iOS 11.0, *) {
                insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
                kTopSpace -= kNavigationViewBottomSpace
            }
        }
        let vSize = CGSize.yy_imageZoom(w: CGFloat(self.model.image.size.width), h: CGFloat(self.model.image.size.height))
        let v = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: self.view.center.y - vSize.height / 2  - kTopSpace), size: vSize))
        v.image = UIImage(named: "5.jpg")
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imgView)
        self.imgView.image = model.image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewwi
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
        if self.imgView.frame.size.width > scrollView.frame.size.width {
            if (self.imgView.frame.size.height < scrollView.contentSize.height) {
                self.imgView.center = CGPoint(x: scrollView.contentSize.width / 2, y: scrollView.contentSize.height / 2)
            } else {
                self.imgView.center = CGPoint(x: scrollView.contentSize.width / 2, y: scrollView.center.y - kTopSpace)
            }
        } else {
            self.imgView.center = CGPoint(x: self.scrollView.center.x, y: self.scrollView.center.y - kTopSpace)
        }
    }
    
}
