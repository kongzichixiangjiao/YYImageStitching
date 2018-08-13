//
//  YYBaseViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import SCLAlertView
import PKHUD

class YYBaseViewController: UIViewController {

    var function: FunctionType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func scl_alert(title: String, subTitle: String, closeButtonTitle: String = "取消", showCloseButton: Bool = true, buttons: [String], clickedButtonHandler: @escaping (_ tag: Int, _ bTitle: String) -> ()) {
        
        let appearance = SCLAlertView.SCLAppearance (
            showCloseButton: showCloseButton
        )
        let alertView = SCLAlertView(appearance: appearance)
        for i in 0..<buttons.count {
            let buttonTitle = buttons[i]
            let b = alertView.addButton(buttonTitle) {
                clickedButtonHandler(i , buttonTitle)
            }
            b.tag = i
        }
        
        alertView.showSuccess(title, subTitle: subTitle, closeButtonTitle: "取消")
    }
    
    func pk_hud(text: String) {
        HUD.flash(.label(text), delay: 0.6)
    }
    
    func pk_hud_success(title: String = "成功", text: String) {
        HUD.flash(.labeledSuccess(title: title, subtitle: text), delay: 0.8)
    }
    
    func pk_hud_error(title: String = "出错了", text: String) {
        HUD.flash(.labeledError(title: title, subtitle: text), delay: 0.8)
    }
    
    func px_show_hud_progress() {
        HUD.flash(.progress)
    }
    
    func px_hide_hud_progress() {
        HUD.hide()
    }
    
}

extension YYBaseViewController {
    
    public func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        pk_hud_success(text: "保存成功")
    }
}
