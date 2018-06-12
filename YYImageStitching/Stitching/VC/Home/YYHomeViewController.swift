//
//  YYHomeViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/31.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYHomeViewController: YYBaseViewController {
    
    @IBOutlet var phoneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = phoneButton
    }
    
    @IBAction func phone(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func pinjie(_ sender: UIButton) {
        let vc = "Main".yy_storyboard().instantiateViewController(withIdentifier: "YYRootViewController") as! YYRootViewController
        vc.function = .imageJoint
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func caijian(_ sender: UIButton) {
        let vc = YYSelectedImageViewController()
        vc.maxCount = 1
        vc.function = .caijian 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func lvjing(_ sender: UIButton) {
        let vc = YYSelectedImageViewController()
        vc.maxCount = 1 
        vc.function = .addFilter
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func jiugongge(_ sender: UIButton) {
        let vc = YYSelectedImageViewController()
        vc.maxCount = 1
        vc.function = .nine
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func masaike(_ sender: UIButton) {
        let vc = YYSelectedImageViewController()
        vc.maxCount = 1
        vc.function = .mosaic
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
