//
//  YYImageModel.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/20.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Photos

class YYImageModel {
    var asset: PHAsset!
    var row: Int!
    var isSelected: Bool = false
    var isClipped: Bool = false
    var indexPath: IndexPath!
    var sourceImage: UIImage?
    var image: UIImage?
    var scale: CGFloat = 1
    var resultImage: UIImage?
    var clipImage: UIImage?
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = UIColor.orange
    var filter: FilterEnum = .normal
}
