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
    var isSelected: Bool = false
    var indexPath: IndexPath!
    var image: UIImage?
    
    var resultImage: UIImage?
    var borderWidth: CGFloat!
    var borderColor: UIColor!
    var filter: FilterEnum!
    var a: String!
    
    
}
