//
//  YYTViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/11.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYTViewController: YYBaseCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell(nibName: YYCircleCell.identifier)
//        collectionView.alwaysBounceVertical = true
        let configuration = CPWheelLayoutConfiguration.init(withCellSize: CGSize.init(width: 60, height: 60), radius: 200, angular: 30, wheelType: .topCenter)
        let wheelLayout = CPCollectionViewWheelLayout.init(withConfiguration: configuration)
//        collectionView.collectionViewLayout = wheelLayout
        
        collectionView.collectionViewLayout = CollectionViewCircleLayout(withConfiguration: CircleLayoutConfiguration(withCellSize: CGSize(width: 140, height: 140), spacing: 120, offsetX: 0, offsetY: 200))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension YYTViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYCircleCell.identifier, for: indexPath) as! YYCircleCell
        cell.textLabel.text = String(indexPath.row)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("22")
    }
    
}
