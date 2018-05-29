//
//  YYImageView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYImageView: UIImageView {

    var beganPoint: CGPoint = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first
        beganPoint = (touch?.location(in: self))!
        print(beganPoint)
    }

}
