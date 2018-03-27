//
//  YYRootViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYRootViewController: YYMovingViewController {

    lazy var flowLayout: YYStitchingFlowLayout = {
        return YYStitchingFlowLayout()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCell(nibName: YYScaleMovingCell.identifier)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(dataSource)
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

extension YYRootViewController: UICollectionViewPlaceHolderDelegate
{
    func collectionViewPlaceHolderView() -> UIView {
        let v = Bundle.main.loadNibNamed("YYEmptyView", owner: self, options: nil)?.last as! YYEmptyView
        v.frame = collectionView.bounds
        return v
    }
    
    func collectionViewEnableScrollWhenPlaceHolderViewShowing() -> Bool {
        return false
    }
}
extension YYRootViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYScaleMovingCell.identifier, for: indexPath) as! YYScaleMovingCell

        cell.model = self.dataSource[indexPath.row]
        self.imageManager.requestImage(for: cell.model.asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            cell.imgView.image = result ?? UIImage.init(named: "iw_none")
            cell.scrollView.zoomScale = 1
            self.dataSource[indexPath.row].image = result
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aseet = self.dataSource[indexPath.row].asset!
        return CGSize.yy_imageZoom(w: CGFloat(aseet.pixelWidth), h: CGFloat(aseet.pixelHeight))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = YYScaleViewController()
        vc.model = self.dataSource[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
