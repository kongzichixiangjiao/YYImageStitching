//
//  YYNavigationView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum YYScaleType: Int {
    case scaleAdd = 0, scaleSubtraction = 1
}

class YYNavigationView: UIView {
    
    typealias NavigationBackHandler = () -> ()
    typealias NavigationScaleHandler = (_ type: YYScaleType) -> ()
    var navigationBackHandler: NavigationBackHandler?
    var navigationScaleHandler: NavigationScaleHandler?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func loadView() -> YYNavigationView {
        return Bundle.main.loadNibNamed("YYNavigationView", owner: self, options: nil)?.last as! YYNavigationView
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationBackHandler!()
    }
    
    @IBAction func scaleSubtract(_ sender: UIButton) {
        navigationScaleHandler!(.scaleSubtraction)
    }
    
    @IBAction func scaleAdd(_ sender: UIButton) {
        navigationScaleHandler!(.scaleAdd)
    }
}
