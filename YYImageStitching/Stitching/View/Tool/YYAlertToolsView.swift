//
//  YYAlertToolsView.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/30.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum YYAlertToolsViewType: CGFloat {
    case defualt = 0, border = 100, scale = 44, filter = 300
}

class YYAlertToolsView: UIView {
    
    @IBOutlet weak var finishedButtonHeight: NSLayoutConstraint!
    lazy var kFinishedButtonHeight = {return self.finishedButtonHeight.constant}()
    
    public var currentType: YYAlertToolsViewType?
    
    lazy var borderToolsView: YYBorderToolsView = {
        let v = YYBorderToolsView.ga_loadView() as! YYBorderToolsView
        v.progressViewHandler = progressViewHandler
        v.borderToolsViewDidSelectedColorHanlder = borderToolsViewDidSelectedColorHanlder
        return v
    }()
    
    lazy var scaleToolsView: YYScaleToolsView = {
        let v = YYScaleToolsView.ga_loadView() as! YYScaleToolsView
        v.scaleToolsViewHandler = scaleToolsViewHandler
        return v
    }()
    
    lazy var filtersToolsView: YYSelectedFiltersView = {
        let v = YYSelectedFiltersView.ga_loadView() as! YYSelectedFiltersView
        v.filtersToolsViewHandler = filtersToolsViewHandler
        return v
    }()

    lazy var progressViewHandler: YYProgressView.YYProgressViewHandler = {
        [weak self] width, type in
        if let weakSelf = self {
            weakSelf.progressViewHandler(width, type)
        }
    }
    
    lazy var borderToolsViewDidSelectedColorHanlder: YYBorderToolsView.BorderToolsViewDidSelectedColorHanlder = {
        [weak self] color in
        if let weakSelf = self {
            weakSelf.borderToolsViewDidSelectedColorHanlder(color)
        }
    }
    
    lazy var scaleToolsViewHandler: YYScaleToolsView.ScaleToolsViewHandler = {
        [weak self] scale in
        if let weakSelf = self {
            weakSelf.scaleToolsViewHandler(scale)
        }
    }
    
    lazy var filtersToolsViewHandler: YYSelectedFiltersView.FiltersToolsViewHandler = {
        [weak self] type in
        if let weakSelf = self {
            weakSelf.filtersToolsViewHandler(type)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        
        self.addSubview(borderToolsView)
        borderToolsView.yy_addConstraint(toItem: self, top: 44)
        borderToolsView.isHidden = true
        
        self.addSubview(scaleToolsView)
        scaleToolsView.yy_addConstraint(toItem: self, top: 44)
        scaleToolsView.isHidden = true
        
        self.addSubview(filtersToolsView)
        filtersToolsView.yy_addConstraint(toItem: self, top: 44)
        filtersToolsView.isHidden = true
    }
    
    @IBAction func finished(_ sender: UIButton) {
        hide(type: .border)
    }
    
    public func show(type: YYAlertToolsViewType) {
        
        self.currentType = type
        self.frame = CGRect(x: 0, y: backY(isShow: false, type: type), width: MainScreenWidth, height: backH(type: type))
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 3, options: .curveEaseInOut, animations: {
            self.frame = CGRect(x: 0, y: self.backY(isShow: true, type: type), width: MainScreenWidth, height: self.backH(type: type))
        }, completion: nil)
    }
    
    public func hide(type: YYAlertToolsViewType) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
            self.frame = CGRect(x: 0, y: self.backY(isShow: false, type: type), width: MainScreenWidth, height: self.backH(type: type))
        }, completion: { b in
            self.scaleToolsView.isHidden = true
            self.borderToolsView.isHidden = true
            self.filtersToolsView.isHidden = true
            self.removeFromSuperview()
        })
    }
    
    private func backY(isShow: Bool, type: YYAlertToolsViewType) -> CGFloat {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(self)
        switch type {
        case .border:
            borderToolsView.isHidden = false
            return MainScreenHeight + (isShow ? -(type.rawValue + self.kFinishedButtonHeight) : 0)
        case .defualt:
            return MainScreenHeight
        case .scale:
            scaleToolsView.isHidden = false 
            return MainScreenHeight + (isShow ? -(type.rawValue + self.kFinishedButtonHeight) : 0)
        case .filter:
            filtersToolsView.isHidden = false 
            return MainScreenHeight + (isShow ? -(type.rawValue + self.kFinishedButtonHeight) : 0)
        }
    }
    
    private func backH(type: YYAlertToolsViewType) -> CGFloat {
        switch type {
        case .border:
            return type.rawValue + self.kFinishedButtonHeight
        case .defualt:
            return MainScreenHeight
        case .scale:
            return type.rawValue + self.kFinishedButtonHeight
        case .filter:
            return type.rawValue + self.kFinishedButtonHeight
        }
    }
    
    public func updateBorderToolsView(borderWidth: CGFloat, progressColor: UIColor) {
        self.borderToolsView.borderWidth = borderWidth + YYProgressView.space
        self.borderToolsView.progressView.progressColor = progressColor
    }
}


