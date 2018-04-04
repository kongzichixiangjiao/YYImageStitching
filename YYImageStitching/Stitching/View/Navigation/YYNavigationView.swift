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

    @IBOutlet weak var mTitleLabel: UILabel!
    public var myTitle: String! {
        didSet {
            mTitleLabel.text = myTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func loadView() -> YYNavigationView {
        return Bundle.main.loadNibNamed("YYNavigationView", owner: self, options: nil)?.last as! YYNavigationView
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationBackHandler!()
    }
    
}
