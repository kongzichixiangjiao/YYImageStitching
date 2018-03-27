//
//  UIImageView+Extension.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func yy_proportionZoom(w: CGFloat, h: CGFloat) -> CGSize {
        let vW: CGFloat = UIScreen.main.bounds.size.width
        let _: CGFloat = UIScreen.main.bounds.size.height
        let scale: CGFloat = UIScreen.main.scale
        let iW: CGFloat = CGFloat(h) / scale
        let iH: CGFloat = CGFloat(h) / scale
        let h: CGFloat = (iH / iW) * vW
        return CGSize(width: vW, height: h)
    }
}
