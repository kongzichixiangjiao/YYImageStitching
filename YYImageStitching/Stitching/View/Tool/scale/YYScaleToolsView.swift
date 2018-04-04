//
//  YYScaleToolsView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit


class YYScaleToolsView: UIView {
    
    static let height: CGFloat = 44
    
    typealias ScaleToolsViewHandler = (_ scale: CGFloat) -> ()
    var scaleToolsViewHandler: ScaleToolsViewHandler!
    
    @IBAction func scaleAction(sender: UIButton) {
        scaleToolsViewHandler(0.5)
    }
    
    @IBAction func recoverAction(sender: UIButton) {
        scaleToolsViewHandler(1)
    }
    
}
