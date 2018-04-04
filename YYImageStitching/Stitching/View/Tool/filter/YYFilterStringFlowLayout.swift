//
//  YYFilterStringFlowLayout.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYFilterStringFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 50, height: 50)
        minimumInteritemSpacing = 20
        minimumLineSpacing = 20
        scrollDirection = .vertical
    }
    
}
