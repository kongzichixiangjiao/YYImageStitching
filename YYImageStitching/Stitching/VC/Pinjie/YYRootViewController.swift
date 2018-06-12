//
//  YYRootViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import PKHUD

let kSelfViewColor = UIColor.rgb(210, 210, 210)
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
        collectionView.backgroundColor = UIColor.clear
        collectionView.collectionViewLayout = flowLayout
        collectionView.emptyDelegate = self
        collectionView.yy_reloadData()
        collectionView.alwaysBounceVertical = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addPictures(_ sender: UIButton) {
        let vc = UIStoryboard(name: "YYPhotoPicker", bundle: nil).instantiateViewController(withIdentifier: "YYSelectedImageViewController") as! YYSelectedImageViewController
        vc.myDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        shareWX(v: v)
    }
    
    func shareWX(v: UIView) {
        if AppDelegate.shareImage(image: v.yy_screenshot()!) {
            print("去分享")
        } else {
            print("NO~~~~")
        }
    }
    
    @IBAction func setup(_ sender: UIButton) {
        if dataSource.count == 0 {
            pk_hud(text: "没照片你设置什么？")
            return
        }
        let buttons = ["图片间距", "图片边距", "背景色"]
        scl_alert(title: "选择要设置的间距", subTitle: "", showCloseButton: true, buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                if bTitle == "背景色" {
                    weakSelf.setupBackgroundColor()
                    return
                }
                weakSelf.setupSpace(subTitle: bTitle, isLineSpace: (bTitle == "图片间距"))
            }
        }
    }
    
    func setupBackgroundColor() {
        let buttons = ["黑色", "白色", "灰色"]
        scl_alert(title: "背景色", subTitle: "背景色选择", buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                switch tag {
                case 0:
                    weakSelf.view.backgroundColor = UIColor.rgb(0, 0, 0)
                    break
                case 1:
                    weakSelf.view.backgroundColor = UIColor.rgb(255, 255, 255)
                    break
                case 2:
                    weakSelf.view.backgroundColor = UIColor.rgb(200, 200, 200)
                    break
                default:
                    break
                }
            }
        }
    }
    
    func setupSpace(title: String = "设置", subTitle: String, isLineSpace: Bool) {
        let buttons = ["0", "5", "10", "20", "40"]
        scl_alert(title: title, subTitle: subTitle, buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                let space = buttons[tag].int64
                if isLineSpace {
                    weakSelf.flowLayout.minLineSpacing = CGFloat(space)
                    weakSelf.lineSpace = weakSelf.flowLayout.minLineSpacing
                    let layout = weakSelf.flowLayout
                    weakSelf.collectionView.collectionViewLayout = layout
                } else {
                    weakSelf.leftSpace = CGFloat(space)
                }
                weakSelf.collectionView.yy_reloadData()
            }
        }
    }
    
    lazy var scaleViewControllerBackHandler: YYEditViewController.ScaleViewControllerBackHandler = {
        [weak self] img, row in
        self?.dataSource[row].image = img
        self?.collectionView.reloadItems(at: [IndexPath(item: row, section: 0)])
    }
    
    lazy var scaleViewControllerDeleteHandler: YYEditViewController.ScaleViewControllerDeleteHandler = {
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

extension YYRootViewController: YYSelectedImageViewControllerDelegate {
    func selectedImageBack(models: [YYImageModel]) {
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
            let scale = UIScreen.main.scale
            let size = CGSize(width: cell.size.width*scale, height: cell.size.height*scale)
            
            self.imageManager.requestImage(for: cell.model.asset, targetSize: size, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
                cell.imageView.image = result ?? UIImage.init(named: "iw_none")
                self.dataSource[indexPath.row].image = result
                self.dataSource[indexPath.row].sourceImage = result
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
        let buttons = ["滤镜", "裁剪", "删除", "瞎编辑", "还原"]
        scl_alert(title: "你想干啥去？", subTitle: "", showCloseButton: true, buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                switch tag {
                case 0:
                    let vc = YYFilterViewController(nibName: "YYFilterViewController", bundle: nil)
                    vc.function = weakSelf.function
                    vc.model = weakSelf.dataSource[indexPath.row]
                    vc.delegate = self
                    weakSelf.navigationController?.pushViewController(vc, animated: true)
                    break
                case 1:
                    let vc = YYClipperViewController()
                    vc.function = weakSelf.function
                    vc.targetImage = weakSelf.dataSource[indexPath.row].image
                    vc.delegate = self
                    weakSelf.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    self?.dataSource.remove(at: indexPath.row)
                    self?.collectionView.reloadData()
                    break
                case 3:
                    let vc = UIStoryboard.yy_main(vcName: "YYEditViewController") as! YYEditViewController
                    vc.scaleViewControllerBackHandler = weakSelf.scaleViewControllerBackHandler
                    vc.scaleViewControllerDeleteHandler = weakSelf.scaleViewControllerDeleteHandler
                    vc.model = weakSelf.dataSource[indexPath.row]
                    weakSelf.navigationController?.pushViewController(vc, animated: true)
                    break
                case 4:
                    weakSelf.dataSource[indexPath.row].image = weakSelf.dataSource[indexPath.row].sourceImage
                    weakSelf.collectionView.reloadData()
                    break
                default:
                    break 
                }
            }
        }
    }
    
}

extension YYRootViewController: YYClipperViewControllerDelegate {
    func clipperViewControllerWithCrop(image: UIImage) {
        self.dataSource[0].image = image
        self.collectionView.reloadData()
    }
}

extension YYRootViewController: YYFilterViewControllerDelegate {
    func filterViewControllerEditFinished(image: UIImage) {
        self.collectionView.reloadData()
    }

}


