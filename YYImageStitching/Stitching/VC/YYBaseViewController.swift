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
    

    func scl_alert(title: String, subTitle: String, closeButtonTitle: String = "取消", showCloseButton: Bool = false, buttons: [String], clickedButtonHandler: @escaping (_ tag: Int, _ bTitle: String) -> ()) {
        
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
        HUD.flash(.label(text), delay: 1.0)
    }

}
