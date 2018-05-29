//
//  YYRootViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

let kSelfViewColor = UIColor.rgb(240, 240, 240)
class YYRootViewController: YYMovingViewController {
    
    var leftSpace: CGFloat = 0
    var lineSpace: CGFloat = 0
    
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
        updateCollectionViewFrame(left: 0, bottom: 44, right: 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.collectionViewLayout = flowLayout
        collectionView.emptyDelegate = self
        collectionView.yy_reloadData()
        collectionView.alwaysBounceVertical = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addPictures(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YYStitchingViewController") as! YYStitchingViewController
        vc.myDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sharePic(_ sender: UIButton) {
        print("share")
        jointImages()
    }
    
    func jointImages() {
        if (dataSource.count == 0) {return}
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.frame = CGRect.zero
        for model in dataSource {
            if let image = model.image {
                let imageView = UIImageView()
                imageView.image = image
                imageView.frame = CGRect(x: leftSpace, y: v.height + lineSpace, width: self.view.width - leftSpace * 2, height: image.height * ((self.view.width - leftSpace * 2) / image.width))
                v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: v.height + imageView.height + lineSpace)
                v.addSubview(imageView)
            }
        }
        
        if AppDelegate.shareImage(image: v.yy_screenshot()!) {
            print("去分享")
        } else {
            print("NO~~~~")
        }
    }
    
    @IBAction func lineSpace(_ sender: UIButton) {
        if dataSource.count == 0 {
            return
        }
        
        flowLayout.minLineSpacing = flowLayout.minLineSpacing == 0 ? 5 : (flowLayout.minLineSpacing == 5 ? 10 : 0)
        
        lineSpace = flowLayout.minLineSpacing
        
        let layout = flowLayout
        collectionView.collectionViewLayout = layout
        collectionView.yy_reloadData()
    }
    
    @IBAction func leftAndRightSpace(_ sender: UIButton) {
        if dataSource.count == 0 {
            return
        }
        leftSpace = leftSpace == 0 ? 5 : (leftSpace == 5 ? 10 : 0)
        collectionView.yy_reloadData()
    }
    
    @IBAction func nineSegmentation(_ sender: UIButton) {
        let vc = YYClipperViewController()
        vc.targetImage = self.dataSource[0].image
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var scaleViewControllerBackHandler: YYScaleViewController.ScaleViewControllerBackHandler = {
        [weak self] img, row in
        self?.dataSource[row].image = img
        self?.collectionView.reloadItems(at: [IndexPath(item: row, section: 0)])
    }
    
    lazy var scaleViewControllerDeleteHandler: YYScaleViewController.ScaleViewControllerDeleteHandler = {
        [weak self] row in
        if let weakSelf = self {
            if weakSelf.dataSource.count == 0 {
                return
            }
            weakSelf.dataSource.remove(at: row)
            weakSelf.collectionView.yy_reloadData()
        }
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
            return CGSize.yy_imageZoom(baseW: self.collectionView.frame.size.width - 2*leftSpace, w: CGFloat(aseet.pixelWidth), h: CGFloat(aseet.pixelHeight))
        }
        return CGSize.yy_imageZoom(baseW: self.collectionView.frame.size.width - 2*leftSpace, w: img.size.width, h: img.size.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.yy_main(vcName: "YYScaleViewController") as! YYScaleViewController
        vc.scaleViewControllerBackHandler = self.scaleViewControllerBackHandler
        vc.scaleViewControllerDeleteHandler = self.scaleViewControllerDeleteHandler
        vc.model = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension YYRootViewController: YYClipperViewControllerDelegate {
    func clipperViewControllerWithCrop(image: UIImage) {
        self.dataSource[0].image = image
        self.collectionView.reloadData()
    }
}


