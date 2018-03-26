//
//  YYBaseCollectionViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/22.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYBaseCollectionViewController: YYPickerImageViewController {

    public var dataSource: [YYImageModel] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = YYMovingFlowLayout()
        let c = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = UIColor.white
        self.view.addSubview(c)
        return c
    }()
    
    public func registerCell(nibName: String) {
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    public func updateFrame(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        collectionView.frame = CGRect(x: left,
                                      y: top,
                                      width: self.view.frame.width - left - right,
                                      height: self.view.frame.height - top - bottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
}

extension YYBaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
