//
//  YYStitchingViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYStitchingViewControllerDelegate: class {
    func stichingBack(models: [YYImageModel])
}

class YYStitchingViewController: YYBaseCollectionViewController {
    
    weak var myDelegate: YYStitchingViewControllerDelegate?
    
    var selectedArray: [YYImageModel] = []
    var isEdit: Bool = true
    
    lazy var flowLayout: YYStitchingFlowLayout = {
        let f = YYStitchingFlowLayout()
        f.minLineSpacing = 10
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        loadData()
        
        self.collectionView.reloadData()
    }
    
    private func initViews() {
        self.navigationController?.title = "相册"
        
        updateCollectionViewFrame(top: 0, left: 10, bottom: 44, right: 10)
        collectionView.collectionViewLayout = flowLayout
        registerCell(nibName: YYMovingCell.identifier)
    }
    
    private func loadData() {
        let assets = initAssets()
        for i in 0..<assets.count {
            let asset = assets[i]
            let model = YYImageModel()
            model.asset = asset
            model.isSelected = false
            dataSource.append(model)
        }
        
        if !self.isEdit {
            self.selectedArray.removeAll()
        }
    }
    
    @IBAction func selectedAction(_ sender: UIButton) {
        cancleAction(sender)
        
        sender.isSelected = !sender.isSelected
        
        editAction(sender)
    }
    
    func editAction(_ sender: UIButton) {
        self.isEdit = sender.isSelected
        self.collectionView.reloadData()
        if !self.isEdit {
            self.selectedArray.removeAll()
        }
    }
    
    func cancleAction(_ sender: UIButton) {
        if sender.isSelected {
            for model in selectedArray {
                model.isSelected = false
            }
        }
    }
    
    @IBAction func finishedAction(_ sender: UIButton) {
        myDelegate?.stichingBack(models: self.selectedArray)
        self.navigationController?.popViewController(animated: true)
    }
}

extension YYStitchingViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYMovingCell.identifier, for: indexPath) as! YYMovingCell
        cell.contentView.backgroundColor = UIColor.randomColor()
        cell.titleLabel.text = String(indexPath.row)
        cell.model = self.dataSource[indexPath.row]
        cell.setupEdit(isEdit: isEdit)
        
        self.imageManager.requestImage(for: cell.model.asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            cell.imageView.image = result ?? UIImage.init(named: "iw_none")
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isEdit {
            let model = self.dataSource[indexPath.row]
            model.isSelected = !model.isSelected
            collectionView.reloadItems(at: [indexPath])
            if model.isSelected {
                model.indexPath = indexPath
                selectedArray.append(model)
            } else {
                var arr = selectedArray
                for i in 0..<arr.count {
                    let item = arr[i]
                    if item.indexPath == model.indexPath {
                        selectedArray.remove(at: i)
                    }
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
}
