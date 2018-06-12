//
//  YYFilterViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import GPUImage

protocol YYFilterViewControllerDelegate: class {
    func filterViewControllerEditFinished(image: UIImage)
}

class YYFilterViewController: YYBaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var finishedItem: UIBarButtonItem!
    @IBOutlet var backItem: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var progressLabel: UILabel!
    
    weak var delegate: YYFilterViewControllerDelegate?
    
    var model: YYImageModel?
    var targetImage: UIImage?
    var thumbnailImage: UIImage?
    
    var dataSource: [YYFilterModel] = []
    var filterModel: YYFilterModel!
    var groupFilter = GPUImageFilterGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initViews()
        initData()
        registerCells()
    }
    
    func initData() {
//        let path = Bundle.main.path(forResource: "filters", ofType: "plist", inDirectory: nil) ?? ""
        let path = Bundle.main.path(forResource: "filtersNew", ofType: "plist", inDirectory: nil) ?? ""
        
        let arr = NSArray.init(contentsOf: URL(fileURLWithPath: path)) as! [[String : Any]]
        if let list = ([YYFilterModel].deserialize(from: arr) as? [YYFilterModel]) {
            self.dataSource = list
            self.filterModel = self.dataSource.first
        }
        
        for model in dataSource {
            initFilters(model: model)
        }
    }
    
    func initFilters(model: YYFilterModel) {
        self.filterModel = model
        model.thumbnailImage = GPUImageFilter(isThumbnail: true)
        
        collectionView.reloadData()
    }
    
    func registerCells() {
        collectionView.yy_register(nibName: YYFilterBottomCell.identifier)
    }
    
    func initViews() {
        self.navigationItem.leftBarButtonItem = backItem
        self.navigationItem.rightBarButtonItem = finishedItem
        
        if let image = targetImage {
            imageView.image = image
            thumbnailImage = image.yy_compressImage(100, imageLength: 100)
        } else {
            targetImage = model?.image
            imageView.image = model?.image
            thumbnailImage = model?.image?.yy_compressImage(100, imageLength: 100)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func finished(_ sender: UIBarButtonItem) {
        
        if (function == .addFilter) {
            scl_alert(title: "选择", subTitle: "确定保存吗？", buttons: ["保存"]) {
                [weak self] tag, bTitle in
                if let weakSelf = self {
                    guard let img = weakSelf.imageView.image else {
                        weakSelf.pk_hud(text: "图片有毒")
                        return
                    }
                    weakSelf.saveImage(image: img)
                }
            }
            return
        }
        if (function == .imageJoint) {
            self.model?.image = self.imageView.image
        }
        delegate?.filterViewControllerEditFinished(image: self.imageView.image!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        delegate?.filterViewControllerEditFinished(image: self.imageView.image!)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer) {
        let buttons = ["冷", "怀旧", "黑白", "色调", "岁月", "单色", "褪色", "冲印", "烙黄"]
        let filters = [FilterEnum.leng, FilterEnum.huaijue, FilterEnum.heibai, FilterEnum.sediao, FilterEnum.suiyue, FilterEnum.danse, FilterEnum.tuise, FilterEnum.chongyin, FilterEnum.laohuang]
        scl_alert(title: "滤镜", subTitle: "各种滤镜任你选", buttons: buttons) {
            [weak self] tag, bTitle in
            if let weakSelf = self {
                weakSelf.changeFilterImage(type: filters[tag])
            }
        }
    }
    
    func originalImage() -> UIImage {
        var image: UIImage
        if let img = targetImage {
            image = img
        } else {
            image = model!.image!
        }
        return image
        
    }
    
    func changeFilterImage(type: FilterEnum) {
        let image: UIImage = originalImage()
        YYFilterManager.shared.outputImage(originalImage: image, type: type) {
            [weak self] img,success  in
            if let weakSelf = self {
                if success {
                    if let img = weakSelf.targetImage {
                        weakSelf.targetImage = img
                    } else {
                        weakSelf.model?.filter = type
                        weakSelf.model?.image = img
                    }
                    
                    weakSelf.imageView.image = img
                } else {
                    weakSelf.pk_hud(text: "程序猿是傻蛋，失败了！")
                }
            }
        }
    }
    
    func GPUImageFilter(isThumbnail: Bool = false) -> UIImage? {
        var filter: GPUImageOutput!
        var colormatrix: [Float]!
        
        switch YYFilterType(rawValue: self.filterModel.type) {
        case .saturation?:
            filter = GPUImageSaturationFilter()
            (filter as! GPUImageSaturationFilter).saturation = CGFloat(slider.value)
            break
        case .contrast?:
            filter = GPUImageContrastFilter()
            (filter as! GPUImageContrastFilter).contrast = CGFloat(slider.value)
            break
        case .brightness?:
            filter = GPUImageBrightnessFilter()
            (filter as! GPUImageBrightnessFilter).brightness = CGFloat(slider.value)
            break
        case .exposure?:
            filter = GPUImageExposureFilter()
            (filter as! GPUImageExposureFilter).exposure = CGFloat(slider.value)
            break
        case .RGBGreen?:
            filter = GPUImageRGBFilter()
            (filter as! GPUImageRGBFilter).green = CGFloat(slider.value)
            break
        case .RGBRed?:
            filter = GPUImageRGBFilter()
            (filter as! GPUImageRGBFilter).red = CGFloat(slider.value)
            break
        case .RGBBlue?:
            filter = GPUImageRGBFilter()
            (filter as! GPUImageRGBFilter).blue = CGFloat(slider.value)
            break
        case .vignette?:
            filter = GPUImageVignetteFilter()
            //            vignetteCenter; (defaults to 0.5, 0.5)
            //            @property (nonatomic, readwrite) GPUVector3 vignetteColor; (defaults to black)
            //            @property (nonatomic, readwrite) CGFloat vignetteStart; Default of 0.5.
            //            @property (nonatomic, readwrite) CGFloat vignetteEnd; Default of 0.75.
            //            (filter as! GPUImageVignetteFilter).vignetteStart = CGFloat(slider.value)
            (filter as! GPUImageVignetteFilter).vignetteEnd = CGFloat(slider.value)
            break
        case .Hue?:
            filter = GPUImageHueFilter()
            (filter as! GPUImageHueFilter).hue = CGFloat(slider.value)
            break
        case .monochrome?:
            filter = GPUImageMonochromeFilter()
            (filter as! GPUImageMonochromeFilter).intensity = CGFloat(slider.value)
            (filter as! GPUImageMonochromeFilter).color = GPUVector4(one: 0.3, two: 0.33, three: 0.4, four: 0.4)
            (filter as! GPUImageMonochromeFilter).setColorRed(0.1, green: 0.3, blue: 0.3)
            break
        case .sharpen?:
            filter = GPUImageSharpenFilter()
            (filter as! GPUImageSharpenFilter).sharpness = CGFloat(slider.value)
            break
        case .Gamma?:
            filter = GPUImageGammaFilter()
            (filter as! GPUImageGammaFilter).gamma = CGFloat(slider.value)
            break
        case .toneCurve?:
            filter = GPUImageToneCurveFilter()
            (filter as! GPUImageToneCurveFilter).setRGBControlPoints([CGPoint(x: 0, y: 0), CGPoint(x: 0.5, y: 0.5), CGPoint(x: 1.0, y: 0.75)])
            break
        case .sepiaTone?:
            filter = GPUImageSepiaFilter()
            (filter as! GPUImageSepiaFilter).intensity = CGFloat(slider.value)
            break
        case .Amotorka?:
            filter = GPUImageAmatorkaFilter()
            break
        case .MissEtikate?:
            filter = GPUImageMissEtikateFilter()
            break
        case .SoftElegance?:
            filter = GPUImageSoftEleganceFilter()
            break
        case .ColorInvert?:
            filter = GPUImageColorInvertFilter()
            break
        case .Grayscale?:
            filter = GPUImageGrayscaleFilter()
            break
        case .Threshold?:
            filter = GPUImageThresholdSketchFilter()
            break
        case .Sketch?:
            filter = GPUImageSketchFilter()
            break
        case .Toon?:
            filter = GPUImageToonFilter()
            break
        case .SmoothToon?:
            filter = GPUImageSmoothToonFilter()
            break
        case .Posterize?:
            filter = GPUImagePosterizeFilter()
            (filter as! GPUImagePosterizeFilter).colorLevels = UInt(CGFloat(slider.value))
            break
        case .Emboss?:
            filter = GPUImageEmbossFilter()
            (filter as! GPUImageEmbossFilter).intensity = CGFloat(slider.value)
            break
        case .GaussianBlur?:
            filter = GPUImageGaussianBlurFilter()
            (filter as! GPUImageGaussianBlurFilter).texelSpacingMultiplier = CGFloat(slider.value)
            break
        case .iOSBlur?:
            filter = GPUImageiOSBlurFilter()
            (filter as! GPUImageiOSBlurFilter).blurRadiusInPixels = 12
            (filter as! GPUImageiOSBlurFilter).saturation = 2
            (filter as! GPUImageiOSBlurFilter).downsampling = 4
            (filter as! GPUImageiOSBlurFilter).rangeReductionFactor = CGFloat(slider.value)
            break
        case .ZoomBlur?:
            filter = GPUImageZoomBlurFilter()
            (filter as! GPUImageZoomBlurFilter).blurSize = CGFloat(slider.value)
            (filter as! GPUImageZoomBlurFilter).blurCenter = CGPoint(x: 0.5, y: 0.5)
            break
        case .BoxBlur?:
            filter = GPUImageBoxBlurFilter()
            break
        case .MotionBlur?:
            filter = GPUImageMotionBlurFilter()
            (filter as! GPUImageMotionBlurFilter).blurSize = CGFloat(slider.value)
            (filter as! GPUImageMotionBlurFilter).blurAngle = 0
            break
        case .Bilateral?:
            filter = GPUImageBilateralFilter()
            (filter as! GPUImageBilateralFilter).distanceNormalizationFactor = CGFloat(slider.value)
            break
        case .Swirl?:
            filter = GPUImageSwirlFilter()
            (filter as! GPUImageSwirlFilter).center = CGPoint(x: 0.5, y: 0.5)
            (filter as! GPUImageSwirlFilter).radius = 0.5
            (filter as! GPUImageSwirlFilter).angle = CGFloat(slider.value)
            break
        case .Bulge?:
            filter = GPUImageBulgeDistortionFilter()
            (filter as! GPUImageBulgeDistortionFilter).center = CGPoint(x: 0.5, y: 0.5)
            (filter as! GPUImageBulgeDistortionFilter).radius = 0.5
            (filter as! GPUImageBulgeDistortionFilter).scale = CGFloat(slider.value)
            break
        case .Pinch?:
            filter = GPUImagePinchDistortionFilter()
            (filter as! GPUImagePinchDistortionFilter).center = CGPoint(x: 0.5, y: 0.5)
            (filter as! GPUImagePinchDistortionFilter).radius = 0.5
            (filter as! GPUImagePinchDistortionFilter).scale = CGFloat(slider.value)
            break
        case .SphereRefraction?:
            filter = GPUImageSphereRefractionFilter()
            (filter as! GPUImageSphereRefractionFilter).center = CGPoint(x: 0.5, y: 0.5)
            (filter as! GPUImageSphereRefractionFilter).radius = CGFloat(slider.value)
            (filter as! GPUImageSphereRefractionFilter).refractiveIndex = 0.71
            break
        case .GlassSphere?:
            filter = GPUImageGlassSphereFilter()
            (filter as! GPUImageGlassSphereFilter).center = CGPoint(x: 0.5, y: 0.5)
            (filter as! GPUImageGlassSphereFilter).radius = CGFloat(slider.value)
            (filter as! GPUImageGlassSphereFilter).refractiveIndex = 0.71
            break
        case .Stretch?:
            filter = GPUImageStretchDistortionFilter()
            (filter as! GPUImageStretchDistortionFilter).center = CGPoint(x: 0.5, y: CGFloat(slider.value))
            break
        case .Dilation?:
            filter = GPUImageDilationFilter.init(radius: 1) // 1, 2, 3, 4
            (filter as! GPUImageDilationFilter).verticalTexelSpacing = CGFloat(slider.value)
            (filter as! GPUImageDilationFilter).horizontalTexelSpacing = 1
            break
        case .Eosion?:
            filter = GPUImageErosionFilter.init(radius: 1) // 1, 2, 3, 4
            (filter as! GPUImageErosionFilter).verticalTexelSpacing = CGFloat(slider.value)
            (filter as! GPUImageErosionFilter).horizontalTexelSpacing = 1
            break
        case .Multiply?:
            filter = GPUImageMultiplyBlendFilter()
            break
        case .Overlay?:
            filter = GPUImageOverlayBlendFilter()
            break
        case .Normal?:
            filter = GPUImageNormalBlendFilter()
            break
        case .Alpha?:
            filter = GPUImageAlphaBlendFilter()
            break
        case .Dissolve?:
            filter = GPUImageDissolveBlendFilter()
            break
        case .Darken?:
            filter = GPUImageDarkenBlendFilter()
            break
        case .Lighten?:
            filter = GPUImageDissolveBlendFilter()
            break
        case .SourceOver?:
            filter = GPUImageSourceOverBlendFilter()
            break
        case .ColorBurn?:
            filter = GPUImageColorBurnBlendFilter()
            break
        case .ColorDodge?:
            filter = GPUImageColorDodgeBlendFilter()
            break
        case .Exclusion?:
            filter = GPUImageExclusionBlendFilter()
            break
        case .Difference?:
            filter = GPUImageDifferenceBlendFilter()
            break
        case .Subtract?:
            filter = GPUImageSubtractBlendFilter()
            break
        case .HardLight?:
            filter = GPUImageHardLightBlendFilter()
            break
        case .SoftLight?:
            filter = GPUImageSoftLightBlendFilter()
            break
        case .ChromaKey?:
            filter = GPUImageChromaKeyFilter()
            break
        case .Mask?:
            filter = GPUImageMaskFilter()
            break
        case .Haze?:
            filter = GPUImageHazeFilter()
            break
        case .LuminanceThreshold?:
            filter = GPUImageLuminanceThresholdFilter()
            break
        case .AdaptiveThreshold?:
            filter = GPUImageAdaptiveThresholdFilter()
            break
        case .Add?:
            filter = GPUImageAddBlendFilter()
            break
        case .Divide?:
            filter = GPUImageDivideBlendFilter()
            break
        case .colormatrix_heibai?:
            colormatrix = colormatrix_heibai
            break
        case .colormatrix_lomo?:
            colormatrix = colormatrix_lomo
            break
        case .colormatrix_huajiu?:
            colormatrix = colormatrix_huajiu
            break
        case .colormatrix_gete?:
            colormatrix = colormatrix_gete
            break
        case .colormatrix_ruihua?:
            colormatrix = colormatrix_ruihua
            break
        case .colormatrix_danya?:
            colormatrix = colormatrix_danya
            break
        case .colormatrix_jiuhong?:
            colormatrix = colormatrix_jiuhong
            break
        case .colormatrix_qingning?:
            colormatrix = colormatrix_qingning
            break
        case .colormatrix_langman?:
            colormatrix = colormatrix_langman
            break
        case .colormatrix_guangyun?:
            colormatrix = colormatrix_guangyun
            break
        case .colormatrix_landiao?:
            colormatrix = colormatrix_landiao
            break
        case .colormatrix_menghuan?:
            colormatrix = colormatrix_menghuan
            break
        case .colormatrix_yese?:
            colormatrix = colormatrix_yese
            break
        case .colormatrix_test?:
            colormatrix = colormatrix_test
            break
        default:
            break
        }
        /*
        if filter == nil {
            pk_hud_error(text: "滤镜创建失败")
            return nil
        }
        
        //        groupFilter.addTarget(filter as! GPUImageInput?)
        
        let img = UIImage(named: "lookup_soft_elegance_1.png")
        let source1 = GPUImagePicture(cgImage: img?.cgImage, smoothlyScaleOutput: true)
        source1?.addTarget(filter as! GPUImageInput?)
        source1?.addTarget(groupFilter)
        source1?.processImage()
        
        let source = GPUImagePicture(image: targetImage)
        source?.addTarget(filter as! GPUImageInput?)
        //        source?.addTarget(groupFilter)
        source?.processImage()
        
        filter.useNextFrameForImageCapture()
        let new = filter.imageFromCurrentFramebuffer()
        
        //        groupFilter.useNextFrameForImageCapture()
        //        let new = groupFilter.imageFromCurrentFramebuffer()
 
//        self.imageView.image = new
        */
        let p = colormatrix.withUnsafeMutableBufferPointer() {
            // 这里，形参是一个含有一个UnsafeMutableBufferPointer的形参，
            // 返回类型为UnsafeMutablePointer的函数类型。
            (buffer: inout UnsafeMutableBufferPointer<Float>) -> UnsafeMutablePointer<Float> in
            return buffer.baseAddress!
        }
        if isThumbnail {
            self.imageView.image = thumbnailImage?.yy_image(colorMatrix: p)
        } else {
            self.imageView.image = targetImage?.yy_image(colorMatrix: p)
        }

        return self.imageView.image
    }
    
    @IBAction func sliderChangeValue(_ sender: UISlider) {
        _ = GPUImageFilter()
        self.filterModel.sliderCurrentValue = sender.value
        progressLabel.text = String(format: "%.2f", sender.value)
    }
    
    func setupSlider() {
        slider.minimumValue = self.filterModel.sliderMinValue
        slider.maximumValue = self.filterModel.sliderMaxValue
        slider.setValue(self.filterModel.sliderCurrentValue, animated: true)
    }
    
}

extension YYFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYFilterBottomCell.identifier, for: indexPath) as! YYFilterBottomCell
        let model = self.dataSource[indexPath.row]
        cell.textLabel.text = model.type
        cell.thumbnailImageView.image = model.thumbnailImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.filterModel.isSelected = false
        self.filterModel = self.dataSource[indexPath.row]
        self.filterModel.isSelected = true
        
        self.title = filterModel.type
        
        setupSlider()
        
        pk_hud(text: self.title!)
        
        if self.filterModel.thumbnailImage == nil {
            self.filterModel.thumbnailImage = GPUImageFilter()
        }
        self.imageView.image = GPUImageFilter()
        
        collectionView.reloadData()
        
        
    }
}
