//
//  YYBorderToolsView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYBorderToolsView: UIView {
    
    @IBOutlet weak var backProgressView: UIView!
    @IBOutlet var borderColorButtons: [UIButton]!
    
    @IBAction func borderColorAction(sender: UIButton) {
        
    }
    
    lazy var progressView: YYProgressView = {
        let v = YYProgressView(frame: self.bounds)
        v.progressViewHandler = progressViewHandler
        return v
    }()
    
    lazy var progressViewHandler: YYProgressView.YYProgressViewHandler = {
        [weak self] width, type in
        if let weakSelf = self {
            weakSelf.progressViewHandler(width, type)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backProgressView.addSubview(progressView)
        progressView.yy_addConstraint(toItem: backProgressView)
    }
}

