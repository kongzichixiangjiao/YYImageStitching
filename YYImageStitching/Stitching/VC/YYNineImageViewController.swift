//
//  YYNineImageViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYNineImageViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var imageView9: UIImageView!
    var imageViews: [UIImageView] = []
    var targetImage: UIImage!
    
    var count = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViews = [imageView1, imageView2, imageView3, imageView4, imageView5, imageView6, imageView7, imageView8, imageView9]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentation(_ sender: UIButton) {
        let vc = YYClipperViewController()
        vc.targetImage = targetImage
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func save(_ sender: UIButton) {
        count = -1
        saveImage()
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

extension YYNineImageViewController: YYClipperViewControllerDelegate {
    func clipperViewControllerWithCrop(image: UIImage) {
        self.targetImage = image
        let w: CGFloat = targetImage.width / 3
        let h: CGFloat = targetImage.height / 3
        
        for i in 0..<imageViews.count {
            let rect = CGRect(x: CGFloat(i % 3) * w, y: CGFloat(i / 3) * h, width: w, height: h)
            imageViews[i].image = cropImage(rect: rect)
        }
    }
}

