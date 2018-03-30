//
//  CGSize+Extension.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension CGSize {
    static func yy_imageZoomWithBaseScreen<T>(w: T, h: T) -> CGSize {
        let vW: CGFloat = UIScreen.main.bounds.size.width
        let _: CGFloat = UIScreen.main.bounds.size.height
        let scale: CGFloat = UIScreen.main.scale
        let iW: CGFloat = (w as! CGFloat) / scale
        let iH: CGFloat = (h as! CGFloat) / scale
        let h: CGFloat = (iH / iW) * vW
        return CGSize(width: vW, height: h)
    }
    
    static func yy_imageZoom<T>(baseW: T, w: T, h: T) -> CGSize {
        let vW: CGFloat = baseW as! CGFloat
        let scale: CGFloat = UIScreen.main.scale
        let iW: CGFloat = (w as! CGFloat) / scale
        let iH: CGFloat = (h as! CGFloat) / scale
        let h: CGFloat = (iH / iW) * vW
        return CGSize(width: vW, height: h)
    }
}
