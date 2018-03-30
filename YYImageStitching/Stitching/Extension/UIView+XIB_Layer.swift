//
//  UIView+Layer.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/29.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
// MARK: Xib 属性设置
protocol UIViewExtensionProtocol {
    var ga_cornerRadius: CGFloat {get set}
    
    var ga_masksToBounds: Bool {get set}
    
    var ga_borderWidth: CGFloat {get set}
    var ga_borderColor: UIColor {get set}
    
    var ga_shadowColor: UIColor {get set}
    var ga_shadowOpacity: CGFloat {get set}
    var ga_shadowOffset: CGSize {get set}
    var ga_shadowRadius: CGFloat {get set}
}

extension UIView: UIViewExtensionProtocol {
    @IBInspectable var ga_cornerRadius: CGFloat {
        get {
            return  self.ga_cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var ga_borderWidth: CGFloat {
        get {
            return self.ga_borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var ga_masksToBounds: Bool {
        get {
            return self.ga_masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var ga_borderColor: UIColor {
        get {
            return self.ga_borderColor
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var ga_shadowColor: UIColor {
        get {
            return self.ga_shadowColor
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var ga_shadowOpacity: CGFloat {
        get {
            return self.ga_shadowOpacity
        }
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var ga_shadowOffset: CGSize {
        get {
            return self.ga_shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var ga_shadowRadius: CGFloat {
        get {
            return self.ga_shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
}
