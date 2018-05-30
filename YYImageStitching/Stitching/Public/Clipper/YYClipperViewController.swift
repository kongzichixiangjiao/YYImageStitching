//
//  YYClipViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/5/23.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import SnapKit

protocol YYClipperViewControllerDelegate: class {
    func clipperViewControllerWithCrop(image: UIImage)
}

enum ClipperType: Int {
    case none = 0, nine = 1
}

class YYClipperViewController: UIViewController {
    
    weak var delegate: YYClipperViewControllerDelegate?
    
    enum CropPostionType {
        case left, right, top, bottom, none, move
    }
    
    enum PercentageType: CGFloat {
        case p_1ratio1 = 1, p_3ratio2 = 1.5, p_16ratio9 = 1.77777778
    }
    var clipperType: ClipperType = .none
    var kSpace: CGFloat = 20
    var kTopSpace: CGFloat = 0
    var kLeftSpace: CGFloat = 0
    var percentageType: PercentageType?
    var beginMoveType: CropPostionType = .none
    var targetImage: UIImage!
    var changeCropFrame: CGRect = CGRect.zero
    var originalFrame: CGRect!
    var cropAreaX: CGFloat = 0
    var cropAreaY: CGFloat = 0
    var cropAreaWidth: CGFloat = 0
    var cropAreaHeight: CGFloat = 0
    
    lazy var bigImageView: YYImageView = {
        let v = YYImageView()
        v.contentMode = .scaleAspectFit
        v.backgroundColor = UIColor.black
        v.isUserInteractionEnabled = true
        return v
    }()
    
    lazy var cropMaskView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: "cropMaskView.png")
        v.isUserInteractionEnabled = false
        return v
    }()
    
    var cropView: UIView = {
        let v = UIView()
        v.isUserInteractionEnabled = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.backgroundColor = UIColor.white
        
        initViews()
        addAllGesture()
        
        initBarButtons()
    }
    
    func initBarButtons() {
        let right = UIBarButtonItem(title: "比例", style: .plain, target: self, action: #selector(rightPercentageBar))
        self.navigationItem.rightBarButtonItem = right
        let otherRight = UIBarButtonItem(title: "裁剪", style: .plain, target: self, action: #selector(otherRightBarCrop))
        self.navigationItem.rightBarButtonItems = [right, otherRight]
    }
    
    @objc func rightPercentageBar() {
        let action = UIAlertAction(title: "1:1", style: .default) { (action) in
            self.percentageType = .p_1ratio1
            self.setUpCropLayer(isMoveCropView: true)
        }
        let action1 = UIAlertAction(title: "16:9", style: .default) { (action) in
            self.percentageType = .p_16ratio9
            self.setUpCropLayer(isMoveCropView: true)
        }
        let action2 = UIAlertAction(title: "3:2", style: .default) { (action) in
            self.percentageType = .p_3ratio2
            self.setUpCropLayer(isMoveCropView: true)
        }
        let cancle = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        YYAlertViewController(title: "比例", message: "请选择个事故比例", preferredStyle: .actionSheet, actions: [action, action1, action2, cancle]).show(vc: self)
    }
    
    @objc func otherRightBarCrop() {
        let action = UIAlertAction(title: "确定", style: .default) { (action) in
            self.delegate?.clipperViewControllerWithCrop(image: self.cropImage())
            self.navigationController?.popViewController(animated: true)
            DispatchQueue.main.async {
                self.targetImage = self.cropImage()
                self.setUpCropLayer()
            }
        }
        let action1 = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        YYAlertViewController(title: "确认", message: "确定裁剪吗？", preferredStyle: .alert, actions: [action, action1]).show(vc: self)
    }
    
    
    func initViews() {
        view.addSubview(bigImageView)
        view.addSubview(cropView)
        
        bigImageView.frame = CGRect(x: kSpace, y: kSpace + NavigationViewHeight, width: MainScreenWidth - kSpace * 2, height: MainScreenHeight - kSpace * 2 - NavigationViewHeight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpCropLayer()
    }
    
    func setUpCropLayer(isMoveCropView: Bool = false) {
        
        bigImageView.image = targetImage
        
        let bw = bigImageView.width
        let bh = bigImageView.height
        let tw = targetImage.width!
        let th = targetImage.height!

        if (tw > bw || th > bh) {
            bigImageView.contentMode = .scaleAspectFit
            if (tw / th > bw / bh) {
                cropAreaWidth = bw
                cropAreaHeight = th * bw / tw
            } else {
                cropAreaHeight = bh
                cropAreaWidth = tw * bh / th
            }
        } else {
            bigImageView.contentMode = .center
            cropAreaWidth = tw
            cropAreaHeight = th
        }
        cropAreaY = (bh - min(cropAreaHeight, bh)) / 2 + kSpace
        cropAreaX = (bw - min(cropAreaWidth, bw)) / 2 + kSpace
        
        kTopSpace = (bigImageView.height - cropAreaHeight) / 2
        kLeftSpace = (bigImageView.width - cropAreaWidth) / 2
        
        if (percentageType == .p_1ratio1) {
            let s = min(cropAreaWidth, cropAreaHeight)
            cropMaskView.frame = CGRect(x: kLeftSpace, y: kTopSpace, width: s, height: s)
        } else {
            cropMaskView.frame = CGRect(x: kLeftSpace, y: kTopSpace, width: cropAreaWidth, height: cropAreaHeight)
        }
        
        changeCropFrame = cropMaskView.frame
        bigImageView.addSubview(cropMaskView)
    }
    
    func addAllGesture() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleDynamicPanGesture(sender:)))
        bigImageView.addGestureRecognizer(pan)
    }
    
    var panBeginPoint = CGPoint.zero
    var panMovePoint = CGPoint.zero
    
    @objc func handleDynamicPanGesture(sender: UIPanGestureRecognizer) {
        let x: CGFloat = changeCropFrame.minX
        let y: CGFloat = changeCropFrame.minY
        let w: CGFloat = changeCropFrame.width
        let h: CGFloat = changeCropFrame.height
        
        if (sender.state == .began) {
            beginMoveType = .move
            
            panBeginPoint = bigImageView.beganPoint
            
            let topRect = CGRect(x: x, y: y, width: w, height: kSpace * 2)
            if (topRect.contains(panBeginPoint)) {
                beginMoveType = .top
            }
            let leftRect = CGRect(x: x, y: y, width: kSpace * 2, height: h)
            if (leftRect.contains(panBeginPoint)) {
                beginMoveType = .left
            }
            let rightRect = CGRect(x: w + x - kSpace, y: y, width: kSpace * 2, height: h)
            if (rightRect.contains(panBeginPoint)) {
                beginMoveType = .right
            }
            let bottomRect = CGRect(x: x - kSpace, y: y + h - kSpace * 2, width: w, height: kSpace * 2)
            if (bottomRect.contains(panBeginPoint)) {
                beginMoveType = .bottom
            }
        } else if (sender.state == .changed) {
            panMovePoint = sender.location(in: sender.view)
            setUpCropMaskViewFrame(type: beginMoveType, movePoint: panMovePoint)

        } else if (sender.state == .ended) {
            // top
            if (cropMaskView.y + 1 < kTopSpace) {
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: kTopSpace, width: changeCropFrame.width, height: changeCropFrame.maxY - kTopSpace)
            }
            // bottom
            if (cropMaskView.maxY > bigImageView.height - kTopSpace + 1) {
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: changeCropFrame.minY, width: changeCropFrame.width, height: bigImageView.height - changeCropFrame.minY - kTopSpace)
            }
            // right
            if (cropMaskView.maxX > bigImageView.width + 1 - kLeftSpace) {
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: changeCropFrame.minY, width: bigImageView.width - changeCropFrame.minX - kLeftSpace, height: changeCropFrame.height)
            }
            // left
            if (cropMaskView.x + 1 < kLeftSpace) {
                cropMaskView.frame = CGRect(x: kLeftSpace, y: changeCropFrame.minY, width: changeCropFrame.width + changeCropFrame.minX - kLeftSpace, height: changeCropFrame.height)
            }
            changeCropFrame = cropMaskView.frame
        }
    }
    
    func setUpCropMaskViewFrame(type: CropPostionType, movePoint: CGPoint) {
        
        switch type {
        case .top:
            if (percentageType == .p_1ratio1) {
                let s = min(changeCropFrame.width, changeCropFrame.height - movePoint.y + changeCropFrame.minY)
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: movePoint.y, width: s, height: s)
            } else {
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: movePoint.y, width: changeCropFrame.width, height: changeCropFrame.height - movePoint.y + changeCropFrame.minY)
            }
            print("top")
            break
        case .bottom:
            if (percentageType == .p_1ratio1) {
                let s = min(changeCropFrame.width, movePoint.y - changeCropFrame.minY)
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: changeCropFrame.minY, width: s, height: s)
            } else {
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: changeCropFrame.minY, width: changeCropFrame.width, height: movePoint.y - changeCropFrame.minY)
            }
            print("bottom")
            break
        case .left:
            if (percentageType == .p_1ratio1) {
                let s = min(changeCropFrame.maxX - movePoint.x, changeCropFrame.height)
                cropMaskView.frame = CGRect(x: movePoint.x, y: changeCropFrame.minY, width: s, height: s)
            } else {
                cropMaskView.frame = CGRect(x: movePoint.x, y: changeCropFrame.minY, width: changeCropFrame.maxX - movePoint.x, height: changeCropFrame.height)
            }
            print("left")
            break
        case .right:
            if (percentageType == .p_1ratio1) {
                let s = min(changeCropFrame.maxX - (changeCropFrame.maxX - movePoint.x) - changeCropFrame.minX, changeCropFrame.height)
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: changeCropFrame.minY, width: s, height: s)
            } else {
                cropMaskView.frame = CGRect(x: changeCropFrame.minX, y: changeCropFrame.minY, width: changeCropFrame.maxX - (changeCropFrame.maxX - movePoint.x) - changeCropFrame.minX, height: changeCropFrame.height)
            }
            
            print("right")
            break
        case .none:
            print("none")
            break
        case .move:
            print("move")
            cropMaskView.center = movePoint
            // right
            if (movePoint.x + changeCropFrame.width / 2 > bigImageView.width - kLeftSpace) {
                cropMaskView.center = CGPoint(x: bigImageView.width - changeCropFrame.width / 2 - kLeftSpace, y: cropMaskView.center.y)
            }
            // left
            if (movePoint.x - changeCropFrame.width / 2 < kLeftSpace) {
                cropMaskView.center = CGPoint(x: changeCropFrame.width / 2 + kLeftSpace, y: cropMaskView.center.y)
            }
            // top
            if (movePoint.y - changeCropFrame.height / 2 < kTopSpace) {
                cropMaskView.center = CGPoint(x: cropMaskView.center.x, y: changeCropFrame.height / 2 + kTopSpace)
            }
            // bottom
            if (movePoint.y + changeCropFrame.height / 2 > bigImageView.height - kTopSpace) {
                cropMaskView.center = CGPoint(x: cropMaskView.center.x, y: bigImageView.height - changeCropFrame.height / 2 - kTopSpace)
            }
            
            break
        }
    }
    
    func cropImage() -> UIImage {
        let imageScale = min(self.bigImageView.frame.size.width/self.targetImage.size.width, (self.bigImageView.frame.size.height - kTopSpace)/self.targetImage.size.height)

        let cropX = (self.changeCropFrame.minX)/imageScale
        let cropY = (self.changeCropFrame.minY - kTopSpace)/imageScale
        let cropWidth = self.changeCropFrame.width/imageScale
        let cropHeight = self.changeCropFrame.height/imageScale
        let cropRect = CGRect(x: cropX, y: cropY, width: cropWidth, height: cropHeight)
 
        let sourceImageRef = self.targetImage.cgImage
        let newImageRef = sourceImageRef?.cropping(to: cropRect)
        let newImage = UIImage(cgImage: newImageRef!)
        return newImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension YYClipperViewController: YYClipperBottomViewDelegate {
    func clipperBottomViewDidSelectItemAt(row: Int) {
        print(row)
    }
}













