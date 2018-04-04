//
//  YYBorderToolsColorFlowLayout.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYBorderToolsColorFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 20, height: 20)
        minimumInteritemSpacing = 20
        minimumLineSpacing = 20
        scrollDirection = .vertical
    }
}


