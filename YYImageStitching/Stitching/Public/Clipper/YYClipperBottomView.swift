//
//  YYClipperBottomView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/24.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYClipperBottomViewDelegate: class {
    func clipperBottomViewDidSelectItemAt(row: Int)
}

class YYClipperBottomView: UICollectionView {

    weak var myDelegate: YYClipperBottomViewDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.yy_register(nibName: YYClipperBottomCell.identifier)
    }

}

extension YYClipperBottomView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYClipperBottomCell.identifier, for: indexPath) as! YYClipperBottomCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        myDelegate?.clipperBottomViewDidSelectItemAt(row: indexPath.row)
    }
}
