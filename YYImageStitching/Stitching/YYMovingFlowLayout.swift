//
//  YYStitchingFlowLayout.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYMovingFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: collectionView!.frame.width / 3 - 10, height: collectionView!.frame.width / 3)
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        scrollDirection = .vertical
    }
}
