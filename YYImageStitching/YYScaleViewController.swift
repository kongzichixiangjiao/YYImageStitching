//
//  YYScaleViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/23.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYScaleViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.delegate = self
        v.zoomScale = 1
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension YYScaleViewController: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("1")
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.zoom(to: <#T##CGRect#>, animated: <#T##Bool#>)
    }
    
}
