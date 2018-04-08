//
//  YYScaleViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/23.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

private var kTopSpace: CGFloat = 0
private let kNavigationViewHeight: CGFloat = 64

class YYScaleViewController: YYPickerImageViewController {
    
    typealias ScaleViewControllerBackHandler = (_ image: UIImage, _ row: Int) -> ()
    var scaleViewControllerBackHandler: ScaleViewControllerBackHandler?
    
    var row: Int = 0
    
    var model: YYImageModel! {
        didSet {
        }
    }
    
    lazy var navigationView: UIView = {
        let v = YYNavigationView.loadView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: kNavigationViewHeight)
        v.navigationBackHandler = navigationBackHandler
        v.navigationScaleHandler = navigationScaleHandler
        return v
    }()
    
    lazy var navigationBackHandler: YYNavigationView.NavigationBackHandler = {
        [weak self] in
        if let weakSelf = self {
//            weakSelf.alertToolsView.hide(type: .defualt)
            weakSelf.clipView.transform = CGAffineTransform.identity
//            weakSelf.changeBackgroundColor(color: weakSelf.clipView.backgroundColor!)
            
            weakSelf.scaleViewControllerBackHandler!(weakSelf.clipView.yy_screenshot()!, weakSelf.row)
            weakSelf.navigationController?.popViewController(animated: true)
        }
    }
    
    lazy var navigationScaleHandler: YYNavigationView.NavigationScaleHandler = {
        [weak self] type in
        switch type {
        case .scaleAdd:
            self?.clipView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            break
        case .scaleSubtraction:
            self?.clipView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            break 
        }
    }
    
    lazy var clipView: YYClipView = {
        let vSize = CGSize.yy_imageZoomWithBaseScreen(w: CGFloat(self.model.image!.size.width), h: CGFloat(self.model.image!.size.height))
        let y: CGFloat = vSize.height > self.view.frame.size.height ? kNavigationViewHeight : self.view.frame.size.height / 2 - vSize.height / 2
        let v = YYClipView(frame: CGRect(origin: CGPoint(x: 0, y: y), size: vSize))
        v.backgroundColor = UIColor.darkText
        return v
    }()
    
    lazy var alertToolsView: YYAlertToolsView = {
        let v = YYAlertToolsView.ga_loadView() as! YYAlertToolsView
        v.progressViewHandler = progressViewHandler
        v.borderToolsViewDidSelectedColorHanlder = borderToolsViewDidSelectedColorHanlder
        v.scaleToolsViewHandler = scaleToolsViewHandler
        v.filtersToolsViewHandler = filtersToolsViewHandler
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kSelfViewColor
        initViews()
    }
    
    private func initViews() {
        
        self.view.addSubview(self.clipView)
        
        self.imageManager.requestImage(for: self.model.asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            self.clipView.image = result ?? UIImage.init(named: "iw_none")
        }
        
        self.view.addSubview(self.navigationView)
    }
    
    lazy var progressViewHandler: YYProgressView.YYProgressViewHandler = {
        [weak self] width, type in
        if let weakSelf = self {
            weakSelf.clipView.adjustSpace(space: width, type: type)
        }
    }
    
    lazy var borderToolsViewDidSelectedColorHanlder: YYBorderToolsView.BorderToolsViewDidSelectedColorHanlder = {
        [weak self] color in
        if let weakSelf = self {
            weakSelf.changeBorderColor(color: color)
        }
    }
    
    lazy var scaleToolsViewHandler: YYScaleToolsView.ScaleToolsViewHandler = {
        [weak self] scale in
        if let weakSelf = self {
            self?.clipView.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        }
    }
    //
    lazy var filtersToolsViewHandler: YYSelectedFiltersView.FiltersToolsViewHandler = {
        [weak self] type in
        if let weakSelf = self {
            YYFilterManager.shared.outputImage(originalImage: weakSelf.clipView.image!, type: type) {
                [weak self] image,success  in
                if let weakSelf = self {
                    if success {
                        weakSelf.clipView.image = image
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func changeBackgroundColor(color: UIColor = UIColor.white) {
        self.view.backgroundColor = color
    }
    
    private func changeBorderColor(color: UIColor = UIColor.white) {
        self.clipView.backgroundColor = color
        self.imageManager.requestImage(for: self.model.asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            self.clipView.image = nil
            self.clipView.image = result
            self.clipView.borderColor = color
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changBackgroundColor(_ sender: UIButton) {
        alertToolsView.show(type: .border)
    }
    
    @IBAction func scaleAction(_ sender: UIButton) {
        alertToolsView.show(type: .scale)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        alertToolsView.show(type: .filter)
    }
    
    deinit {
        print("-----------YYScaleViewController--------------")
    }
    
}

