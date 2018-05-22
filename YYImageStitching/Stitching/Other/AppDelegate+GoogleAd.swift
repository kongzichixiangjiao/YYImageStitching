//
//  AppDelegate+GoogleAd.swift
//  YYImageStitching
//
//  Created by houjianan on 2018/5/22.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import GoogleMobileAds

extension AppDelegate {
    
    func googleAd() {
        // 请使用此应用 ID 完成 Google 移动广告 SDK 指南中的说明：图片拼接 ca-app-pub-3164648306313935~2220325739
        // 请按照横幅广告实现指南来集成 SDK。在使用此广告单元 ID 集成代码时，您需要指定广告类型、尺寸和展示位置：首选 ca-app-pub-3164648306313935/3666512617
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3164648306313935~2220325739")
    }
}
