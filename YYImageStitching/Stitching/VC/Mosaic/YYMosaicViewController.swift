//
//  YYMosaicViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import GPUImage
import PKHUD

class YYMosaicViewController: YYBaseViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    
    var targetImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        HUD.show(.progress)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mosaic()
    }
    
    func mosaic() {
        let m = GPUImageMosaicFilter()
        m.colorOn = false
        m.tileSet = "timg.jpeg"
        m.setInputRotation(kGPUImageRotateRight, at: 0)
        m.useNextFrameForImageCapture()
        let source = GPUImagePicture(image: targetImage)
        source?.addTarget(m)
        source?.processImage()
        let new = m.imageFromCurrentFramebuffer()
        
        
        mosaicView.surfaceImage = targetImage
        mosaicView.image = new
        
        HUD.hide()
    }

    lazy var mosaicView: YYMosaicView = {
        let v = YYMosaicView(frame: CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64))
        self.view.addSubview(v)
        return v
    }()
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        scl_alert(title: "选择", subTitle: "确定保存吗？", buttons: ["保存"]) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                weakSelf.saveImage(image: weakSelf.mosaicView.getSaveView())
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

}
