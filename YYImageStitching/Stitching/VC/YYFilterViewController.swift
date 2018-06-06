//
//  YYFilterViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit


protocol YYFilterViewControllerDelegate: class {
    func filterViewControllerEditFinished(image: UIImage)
}

class YYFilterViewController: YYBaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var finishedItem: UIBarButtonItem!
    @IBOutlet var backItem: UIBarButtonItem!
    
    weak var delegate: YYFilterViewControllerDelegate?
    
    var model: YYImageModel?
    var targetImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.rightBarButtonItem = finishedItem
        
        if let image = targetImage {
            imageView.image = image
        } else {
            imageView.image = model?.image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func finished(_ sender: UIBarButtonItem) {
        
        if (function == .addFilter) {
            scl_alert(title: "选择", subTitle: "确定保存吗？", buttons: ["保存"]) {
                [weak self] tag, bTitle in
                if let weakSelf = self {
                    guard let img = weakSelf.imageView.image else {
                       weakSelf.pk_hud(text: "图片有毒")
                        return
                    }
                    weakSelf.saveImage(image: img)
                }
            }
            return 
        }
        
        delegate?.filterViewControllerEditFinished(image: self.imageView.image!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer) {
        let buttons = ["冷", "怀旧", "黑白", "色调", "岁月", "单色", "褪色", "冲印", "烙黄"]
        let filters = [FilterEnum.leng, FilterEnum.huaijue, FilterEnum.heibai, FilterEnum.sediao, FilterEnum.suiyue, FilterEnum.danse, FilterEnum.tuise, FilterEnum.chongyin, FilterEnum.laohuang]
        scl_alert(title: "滤镜", subTitle: "各种滤镜任你选", buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                weakSelf.changeFilterImage(type: filters[tag])
            }
        }
    }
    
    func getImage() -> UIImage {
        var image: UIImage
        if let img = targetImage {
            image = img
        } else {
            image = model!.image!
        }
        return image

    }
    
    func changeFilterImage(type: FilterEnum) {
        let image: UIImage = getImage()
        YYFilterManager.shared.outputImage(originalImage: image, type: type) {
            [weak self] img,success  in
            if let weakSelf = self {
                if success {
                    if let img = weakSelf.targetImage {
                        weakSelf.targetImage = img
                    } else {
                        weakSelf.model?.filter = type
                        weakSelf.model?.image = img
                    }
                    
                    weakSelf.imageView.image = img
                } else {
                    weakSelf.pk_hud(text: "程序猿是傻蛋，失败了！")
                }
            }
        }
    }

}

