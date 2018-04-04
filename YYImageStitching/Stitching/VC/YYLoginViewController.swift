//
//  YYLoginViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func login(_ sender: UIButton) {
        yy_appdelegate?.window??.rootViewController = UIStoryboard.yy_main().instantiateInitialViewController()
    }
    
    deinit {
        print("-----------YYLoginViewController--------------")
    }
    
    
}
