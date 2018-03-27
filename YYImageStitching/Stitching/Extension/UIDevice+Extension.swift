//
//  UIDevice+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension UIDevice {
    public var isX: Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
