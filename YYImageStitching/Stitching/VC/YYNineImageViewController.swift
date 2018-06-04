//
//  YYNineImageViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import PKHUD
import SCLAlertView

class YYNineImageViewController: YYBaseViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var shareImage: UIImage? = nil
    var imageViews: [UIImageView] = []
    var images: [UIImage] = []
    var imagesRoundness: [UIImage] = []
    var targetImage: UIImage!
    
    var count = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        self.navigationItem.rightBarButtonItem = saveButton
        imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9]
        let w: CGFloat = targetImage.width / 3
        let h: CGFloat = targetImage.height / 3
        
        for i in 0..<imageViews.count {
            let rect = CGRect(x: CGFloat(i % 3) * w, y: CGFloat(i / 3) * h, width: w, height: h)
            imageViews[i].image = cropImage(rect: rect)
            images.append(imageViews[i].image!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        HUD.flash(.labeledSuccess(title: "保存成功", subtitle: ""), delay: 1.2)
        count = -1
        saveImage()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func shape(_ sender: UIButton) {
        let buttons = ["圆形", "方形", "添加滤镜"]
        scl_alert(title: "选择需要的设置", subTitle: "", buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                if (buttons[2] == bTitle) {
                    weakSelf.addFilter()
                    return
                }
                
                for i in 0..<weakSelf.images.count {
                    if "圆形" == bTitle {
                        if weakSelf.imagesRoundness.count != weakSelf.images.count {
                            let circleImage = weakSelf.images[i].yy_circleImage()
                            weakSelf.imagesRoundness.append(circleImage)
                            weakSelf.imageViews[i].image = circleImage
                        } else {
                            let circleImage = weakSelf.imagesRoundness[i]
                            weakSelf.imageViews[i].image = circleImage
                        }
                    } else {
                        let image = weakSelf.images[i]
                        weakSelf.imageViews[i].image = image
                    }
                }
            }
        }
    }
    
    func addFilter() {
        let buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        scl_alert(title: "选一张", subTitle: "一次只能整一张", buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                
            }
        }
    }
    
    @IBAction func scanImage(_ sender: UITapGestureRecognizer) {
        var items = [SKPhoto]()
        for image in self.images {
            let photo = SKPhoto.photoWithImage(image)
            items.append(photo)
        }
        
        let browser = SKPhotoBrowser(photos: items)
        browser.initializePageIndex((sender.view?.tag)! - 1)
        present(browser, animated: true, completion: {})
    }
    
    func saveImage() {
        count += 1
        if count == imageViews.count {
            let resultTitle = "提示"
            let resultMessage = "保存成功, 去手机相册查看"
            
            let alert:UIAlertController = UIAlertController.init(title: resultTitle, message:resultMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        let image = imageViews[count].image
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        saveImage()
    }
    
    func cropImage(rect: CGRect) -> UIImage? {
        if let sourceImageRef = self.targetImage.cgImage {
            let newImageRef = sourceImageRef.cropping(to: rect)
            let newImage = UIImage(cgImage: newImageRef!)
            return newImage
        }
        return nil
    }
    
}



