//
//  YYAlertViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/24.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYAlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, actions: [UIAlertAction]) {
        self.init(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            self.addAction(action)
        }
    }
    
    func show(vc: UIViewController) {
        vc.present(self, animated: true, completion: nil)
    }

}
