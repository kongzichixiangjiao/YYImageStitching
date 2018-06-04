//
//  YYPickerImageViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/19.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import Photos

class YYPickerImageViewController: YYBaseViewController {

    /// 带缓存的图片管理对象
    var imageManager:PHCachingImageManager!
    
    ///缩略图大小
    lazy var assetGridThumbnailSize:CGSize = {
        let scale = UIScreen.main.scale
        let cellSize = CGSize(width: self.view.frame.size.width, height: 100)
        return CGSize(width: cellSize.width*scale, height: cellSize.height*scale)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initImageManager()
    }
    
    private func initImageManager() {
        // 初始化和重置缓存
        self.imageManager = PHCachingImageManager()
        self.resetCachedAssets()
    }
    //重置缓存
    private func resetCachedAssets(){
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    public func initAssets() -> [PHAsset] {
        var assets: [PHAsset] = []
        //获取所有资源
        let allPhotosOptions = PHFetchOptions()
        //按照创建时间倒序排列
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                             ascending: false)]
        //只获取图片
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                 PHAssetMediaType.image.rawValue)
        PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions).enumerateObjects { (asset, index, stop) in
            assets.append(asset)
        }
        return assets
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 将PHAsset对象转为UIImage对象
    public func PHAssetToUIImage(asset: PHAsset) -> UIImage {
        var image = UIImage()
        
        // 新建一个默认类型的图像管理器imageManager
        let imageManager = PHImageManager.default()
        
        // 新建一个PHImageRequestOptions对象
        let imageRequestOption = PHImageRequestOptions()
        
        // PHImageRequestOptions是否有效
        imageRequestOption.isSynchronous = true
        
        // 缩略图的压缩模式设置为无
        imageRequestOption.resizeMode = .none
        
        // 缩略图的质量为高质量，不管加载时间花多少
        imageRequestOption.deliveryMode = .highQualityFormat
        
        // 按照PHImageRequestOptions指定的规则取出图片
        imageManager.requestImage(for: asset, targetSize: CGSize.zero, contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
            (result, _) -> Void in
            image = result!
        })
        return image
    }
}

extension YYPickerImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        print(info[UIImagePickerControllerOriginalImage] ?? "null image")
    }
}
