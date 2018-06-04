//
//  YYClipViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/22.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYClipViewController: YYBaseViewController {

    
    var imageClipperView:ImageClipperView? = nil
    var model: YYImageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        imageClipperView = ImageClipperView(frame: CGRect(x: 20, y: 20 + 64 + 40, width: self.view.frame.size.width - 40, height: self.view.frame.size.height - 20), image: model.image! )
        imageClipperView?.center = self.view.center
        self.view.addSubview(imageClipperView!)
        
        let saveButton = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(saveClip))
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveClip() {
        let image = imageClipperView?.clipImage()
        model.isClipped = true
        model.image = image
//        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        var resultTitle:String?
        var resultMessage:String?
        if error != nil {
            resultTitle = "错误"
            resultMessage = "保存失败,请检查是否允许使用相册"
        } else {
            resultTitle = "提示"
            resultMessage = "保存成功"
        }
        let alert:UIAlertController = UIAlertController.init(title: resultTitle, message:resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
