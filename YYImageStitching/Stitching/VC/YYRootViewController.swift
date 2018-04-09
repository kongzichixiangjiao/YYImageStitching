//
//  YYRootViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

let kSelfViewColor = UIColor.rgb(180, 180, 180)
class YYRootViewController: YYMovingViewController {
    
    lazy var flowLayout: YYRootFlowLayout = {
        return YYRootFlowLayout()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kSelfViewColor
        
        initViews()
    }
    
    func initViews() {
        registerCell(nibName: YYScaleMovingCell.identifier)
        updateCollectionViewFrame(left: 30, right: 30)
        collectionView.backgroundColor = kSelfViewColor
        collectionView.collectionViewLayout = flowLayout
        collectionView.emptyDelegate = self
        collectionView.yy_reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPictures(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YYStitchingViewController") as! YYStitchingViewController
        vc.myDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sharePic(_ sender: UIButton) {
        print("share")
    }
    
    lazy var scaleViewControllerBackHandler: YYScaleViewController.ScaleViewControllerBackHandler = {
        [weak self] img, row in
        self?.dataSource[row].image = img
        self?.collectionView.reloadItems(at: [IndexPath(item: row, section: 0)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    deinit {
        print("-----------YYRootViewController--------------")
    }
}

extension YYRootViewController: YYStitchingViewControllerDelegate {
    func stichingBack(models: [YYImageModel]) {
        if dataSource.count > 0 {
            dataSource += models
        } else {
            dataSource = models
        }
        collectionView.yy_reloadData()
    }
}

extension YYRootViewController: UICollectionViewPlaceHolderDelegate {
    func collectionViewPlaceHolderView() -> UIView {
        let v = Bundle.main.loadNibNamed("YYEmptyView", owner: self, options: nil)?.last as! YYEmptyView
        v.frame = CGRect(x: collectionView.bounds.size.width /  2 - v.frame.size.width / 2, y: collectionView.bounds.size.height /  2 - v.frame.size.height, width: v.frame.size.width, height: v.frame.size.height)
        return v
    }
    
    func collectionViewEnableScrollWhenPlaceHolderViewShowing() -> Bool {
        return false
    }
}

extension YYRootViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYScaleMovingCell.identifier, for: indexPath) as! YYScaleMovingCell
        let model = self.dataSource[indexPath.row] 
        model.row = indexPath.row
        cell.model = model 
        cell.myDelegate = self
        guard let img = self.dataSource[indexPath.row].image else {
            self.imageManager.requestImage(for: cell.model.asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
                cell.imageView.image = result ?? UIImage.init(named: "iw_none")
                self.dataSource[indexPath.row].image = result
            }
            return cell
        }
        cell.imageView.image = img
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let img = self.dataSource[indexPath.row].image else {
            let aseet = self.dataSource[indexPath.row].asset!
            return CGSize.yy_imageZoom(baseW: self.collectionView.frame.size.width, w: CGFloat(aseet.pixelWidth), h: CGFloat(aseet.pixelHeight))
        }
        return CGSize.yy_imageZoom(baseW: self.collectionView.frame.size.width, w: img.size.width, h: img.size.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.yy_main(vcName: "YYScaleViewController") as! YYScaleViewController
        vc.scaleViewControllerBackHandler = self.scaleViewControllerBackHandler
        vc.row = indexPath.row
        vc.model = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension YYRootViewController: YYScaleMovingCellDelegate {
    func deleteItem(row: Int) {
        if self.dataSource.count == 0 {
            return
        }
        self.dataSource.remove(at: row)
        self.collectionView.yy_reloadData()
    }
}
