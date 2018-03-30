//
//  YYRootFlowLayout.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/29.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYRootFlowLayout: UICollectionViewFlowLayout {
    
    var minLineSpacing: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize.zero
        minimumInteritemSpacing = 0
        minimumLineSpacing = minLineSpacing
        scrollDirection = .vertical
    }
}
