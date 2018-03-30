//
//  YYAlertToolsView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYAlertToolsView: UIView {
    
    static let kXIBCount = 0
    static let kBorderToolsView = 1
    
    lazy var borderToolsView: YYBorderToolsView = {
        let v = YYAlertToolsView.ga_loadView(count: YYAlertToolsView.kBorderToolsView) as! YYBorderToolsView
        v.progressViewHandler = progressViewHandler
        return v
    }()
    
    lazy var progressViewHandler: YYProgressView.YYProgressViewHandler = {
        [weak self] width, type in
        if let weakSelf = self {
            print(type)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderToolsView.yy_addConstraint(toItem: self)
    }
    
}


