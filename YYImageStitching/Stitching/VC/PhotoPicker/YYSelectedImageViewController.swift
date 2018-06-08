//
//  YYSelectedImageViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Photos
import PKHUD

protocol YYSelectedImageViewControllerDelegate: class {
    func selectedImageBack(models: [YYImageModel])
}

class YYSelectedImageViewController: YYBaseCollectionViewController {
    
    weak var myDelegate: YYSelectedImageViewControllerDelegate?
    
    var assets: [PHAsset] = []
    var selectedArray: [YYImageModel] = []
    var isEdit: Bool = true
    var maxCount: Int = 9
    
    lazy var flowLayout: YYStitchingFlowLayout = {
        let f = YYStitchingFlowLayout()
        f.minLineSpacing = 2
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
        loadData(assets: initAssets())
        
        self.collectionView.reloadData()
    }
    
    private func initViews() {
        self.navigationController?.title = "相册"
        
        updateCollectionViewFrame(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.collectionViewLayout = flowLayout
        registerCell(nibName: YYMovingCell.identifier)
        
        let leftBar = UIBarButtonItem(title: "图片库", style: .plain, target: self, action: #selector(leftBar(sender:)))
        self.navigationItem.leftBarButtonItem = leftBar
        
        let rightBar = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(selectedFinished(sender:)))
        self.navigationItem.rightBarButtonItem = rightBar
    }
    
    @objc func selectedFinished(sender: UIBarButtonItem) {
        if (selectedArray.count == 0) {
            HUD.flash(.labeledError(title: "提醒", subtitle: "请选择图片"), delay: 2.0)
            return
        }
        
        if (function == .nine) {
            self.imageManager.requestImage(for: self.selectedArray.first!.asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
                let image = result ?? UIImage.init(named: "iw_none")
                let vc = YYClipperViewController()
                vc.function = self.function
                vc.targetImage = image
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if (function == .addFilter) {
            self.imageManager.requestImage(for: self.selectedArray.first!.asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
                let image = result ?? UIImage.init(named: "iw_none")
                let vc = YYFilterViewController(nibName: "YYFilterViewController", bundle: nil)
                vc.function = self.function
                vc.delegate = self
                vc.targetImage = image
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if (function == .mosaic) {
            self.imageManager.requestImage(for: self.selectedArray.first!.asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
                let image = result ?? UIImage.init(named: "iw_none")
                let vc = YYMosaicViewController(nibName: "YYMosaicViewController", bundle: nil)
                vc.function = self.function
                vc.targetImage = image
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            myDelegate?.selectedImageBack(models: self.selectedArray)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func leftBar(sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "YYPhotoPicker", bundle: nil).instantiateViewController(withIdentifier: "YYPhotoGroupsController") as! YYPhotoGroupsController
        vc.mediaType = .image
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func loadData(assets: [PHAsset]) {
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

}

extension YYSelectedImageViewController {
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
            if model.isSelected {
                if (maxCount == selectedArray.count) {
                    model.isSelected = !model.isSelected
                    collectionView.reloadItems(at: [indexPath])
                    HUD.flash(.labeledError(title: "提醒", subtitle: "最多选择\(maxCount)张"), delay: 1)
                    return
                }
                model.indexPath = indexPath
                selectedArray.append(model)
                collectionView.reloadItems(at: [indexPath])
            } else {
                var arr = selectedArray
                for i in 0..<arr.count {
                    let item = arr[i]
                    if item.indexPath == model.indexPath {
                        selectedArray.remove(at: i)
                    }
                }
                collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
}

extension YYSelectedImageViewController: YYPhotoGroupsControllerDelegate {
    func photoGroupsDidSelected(assets: [PHAsset]) {
        dataSource.removeAll()
        selectedArray.removeAll()
        loadData(assets: assets)
        collectionView.reloadData()
    }
}

extension YYSelectedImageViewController: YYFilterViewControllerDelegate {
    func filterViewControllerEditFinished(image: UIImage) {
        
    }
}
