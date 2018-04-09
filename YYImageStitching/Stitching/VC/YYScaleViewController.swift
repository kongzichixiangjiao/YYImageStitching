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
    
    typealias ScaleViewControllerDeleteHandler = (_ row: Int) -> ()
    var scaleViewControllerDeleteHandler: ScaleViewControllerDeleteHandler?
    
    var model: YYImageModel!
    
    lazy var navigationView: YYNavigationView = {
        let v = YYNavigationView.loadView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: kNavigationViewHeight)
        v.navigationBackHandler = navigationBackHandler
        return v
    }()
    
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
    
    lazy var navigationBackHandler: YYNavigationView.NavigationBackHandler = {
        [weak self] in
        if let weakSelf = self {
            weakSelf.navigationBackAction()
        }
    }
    
    func navigationBackAction() {
        clipView.transform = CGAffineTransform.identity
        changeBackgroundColor(color: UIColor.white)
        
        scaleViewControllerBackHandler!(clipView.yy_screenshot()!, self.model.row)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kSelfViewColor
        
        initViews()
    }
    
    private func initViews() {
        self.view.addSubview(self.clipView)
        self.view.addSubview(self.navigationView)
        
        self.navigationView.myTitle = ""
        
        changeTransform(scale: self.model.scale)
        changeBorderColor(color: self.model.borderColor)
        changeBorderWidth(width: self.model.borderWidth, type: .add)
        changeFilterImage(type: self.model.filter)
    }
    
    lazy var progressViewHandler: YYProgressView.YYProgressViewHandler = {
        [weak self] width, type in
        if let weakSelf = self {
            weakSelf.model.borderWidth = width
            weakSelf.changeBorderWidth(width: width, type: type)
        }
    }
    
    lazy var borderToolsViewDidSelectedColorHanlder: YYBorderToolsView.BorderToolsViewDidSelectedColorHanlder = {
        [weak self] color in
        if let weakSelf = self {
            weakSelf.model.borderColor = color 
            weakSelf.changeBorderColor(color: color)
        }
    }
    
    lazy var scaleToolsViewHandler: YYScaleToolsView.ScaleToolsViewHandler = {
        [weak self] scale in
        if let weakSelf = self {
            weakSelf.model.scale = scale
            weakSelf.changeTransform(scale: scale)
        }
    }
    
    lazy var filtersToolsViewHandler: YYSelectedFiltersView.FiltersToolsViewHandler = {
        [weak self] type in
        if let weakSelf = self {
            weakSelf.changeFilterImage(type: type)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        alertToolsView.hide(type: .defualt)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func changeFilterImage(type: FilterEnum) {
        
        self.imageManager.requestImage(for: self.model.asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            guard let image = result else {
                return
            }
            YYFilterManager.shared.outputImage(originalImage: image, type: type) {
                [weak self] img,success  in
                if let weakSelf = self {
                    if success {
                        weakSelf.model.filter = type
                        weakSelf.clipView.image = img
                    } else {
                        weakSelf.clipView.image = image
                    }
                }
            }
        }
    }
    
    private func changeBorderWidth(width: CGFloat, type: YYClipViewSpaceType) {
        clipView.adjustSpace(space: width, type: type)
    }
    
    private func changeBackgroundColor(color: UIColor = UIColor.white) {
        self.view.backgroundColor = color
    }
    
    private func changeBorderColor(color: UIColor = UIColor.white) {
        self.clipView.backgroundColor = color
        self.clipView.borderColor = color
    }
    
    func changeTransform(scale: CGFloat) {
        clipView.transform = CGAffineTransform.init(scaleX: scale, y: scale)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changBackgroundColor(_ sender: UIButton) {
        alertToolsView.show(type: .border)
        alertToolsView.updateBorderToolsView(borderWidth: self.model.borderWidth, progressColor: self.model.borderColor)
    }
    
    @IBAction func scaleAction(_ sender: UIButton) {
        alertToolsView.show(type: .scale)
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        alertToolsView.show(type: .filter)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "注意咯", message: "疯了吧，删我？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "没疯", style: .default) { (action) in
            
        }
        let deleteAction = UIAlertAction(title: "就删你", style: .destructive) { (action) in
            self.scaleViewControllerDeleteHandler!(self.model.row)
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        print("-----------YYScaleViewController--------------")
    }
    
}

