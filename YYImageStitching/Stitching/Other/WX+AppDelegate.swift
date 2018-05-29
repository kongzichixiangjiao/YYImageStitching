//
//  WX+AppDelegate.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/4/8.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    static func shareImage(scene: WXScene = WXSceneSession, image: UIImage) -> Bool {
        WXApi.isWXAppInstalled()
        
        let message = WXMediaMessage()
        //        message.title = "23123"
        //        message.description = "123123"
        //        message.messageExt  = messageExt
        //        message.messageAction = messageAction
        //        message.mediaTagName  = "tagName"
        //        message.setThumbImage(image)
        
        let imageObject = WXImageObject()
        imageObject.imageData = UIImagePNGRepresentation(image)
        message.mediaObject = imageObject
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(scene.rawValue)
        
        return WXApi.send(req)
    }
    
    func onResp(_ resp: BaseResp!) {
        print(resp)
    }
    
    func wx_registerApp() {
        WXApi.registerApp("wxe1493b647daa5a07")
    }
    
    func wx_application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
}


