//
//  YYGuideImageViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYGuideImageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
         initViews()
    }
    
    private func initViews() {
        // 首页背景图
        let imageView = UIImageView.init(image: UIImage.init(named: "view_bg_image.png"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        // 引导页案例
        //        let gifArray = ["shopping.gif", "guideImage6.gif", "guideImage7.gif", "guideImage8.gif", "adImage3.gif", "adImage4.gif"]
        //        let imageArray = ["guideImage1.jpg", "guideImage2.jpg", "guideImage3.jpg", "guideImage4.jpg", "guideImage5.jpg"]
        let imageGifArray = ["guideImage1.jpg","guideImage6.gif","guideImage7.gif","guideImage3.jpg", "guideImage5.jpg"]
        let guideView = GuidePageView.init(images: imageGifArray, loginRegistCompletion: {
            UIApplication.shared.delegate?.window??.rootViewController = YYLoginViewController(nibName: "YYLoginViewController", bundle: nil)
        }) {
            UIApplication.shared.delegate?.window??.rootViewController = YYLoginViewController(nibName: "YYLoginViewController", bundle: nil)
//            UIApplication.shared.delegate?.window??.rootViewController = UIStoryboard.yy_main().instantiateInitialViewController()
        }
        self.view.addSubview(guideView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
