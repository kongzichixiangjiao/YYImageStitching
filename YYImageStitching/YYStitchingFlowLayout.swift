//
//  YYStitchingFlowLayout.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/22.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYStitchingFlowLayout: UICollectionViewFlowLayout {
    
    var minLineSpacing: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize.zero
        minimumInteritemSpacing = 0
        minimumLineSpacing = minLineSpacing
        scrollDirection = .vertical
    }
}
