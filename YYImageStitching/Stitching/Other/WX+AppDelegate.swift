//
//  WX+AppDelegate.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/8.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func shareWechat() {
        WXApi.registerApp("")
        
        let message = WXMediaMessage()
        message.setThumbImage(UIImage())
        
        let objc = WXImageObject()
        objc.imageData = Data()
        
        message.mediaObject = objc
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(WXSceneSession.rawValue)
        WXApi.send(req)
    }
    
    func onResp(_ resp: BaseResp!) {
        
    }
    
    func wx_application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
}


