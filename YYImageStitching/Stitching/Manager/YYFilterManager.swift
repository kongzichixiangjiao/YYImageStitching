//
//  YYFilterManager.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/3/31.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum FilterEnum: String {
    case leng = "CIColorMonochrome",
    huaijue = "CIPhotoEffectInstant",
    heibai = "CIPhotoEffectNoir",
    sediao = "CIPhotoEffectTonal",
    suiyue = "CIPhotoEffectTransfer",
    danse = "CIPhotoEffectMono",
    tuise = "CIPhotoEffectFade",
    chongyin = "CIPhotoEffectProcess",
    laohuang = "CIPhotoEffectChrome"
}

extension UIImage {
    
    func yy_filter(type: FilterEnum) -> UIImage {
        //CIImage
        let ciImage = CIImage(image: self)
        // CIFilter
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        
        //设置模糊度
        //        blurFilter.setValue(5, forKey: "inputAngle")
        //        blurFilter.setValue(UIColor.redColor(), forKey: "inputContrast")
        blurFilter?.setValue(2, forKey: "inputRadius")
        //        blurFilter.setValue(1, forKey: "inputIntensity")
        //        blurFilter.setValue(ciImage, forKey: "inputImage")
        
        //构建一个滤镜图表
        let sepiaColor=CIColor(red: 0.1, green: 0.2, blue: 0.6)
        let monochromeFilter = CIFilter(name: type.rawValue, withInputParameters:["inputColor":sepiaColor,"inputIntensity":1.0])
        monochromeFilter?.setValue(ciImage, forKey: "inputImage")
        
        monochromeFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        // 将图片输入到滤镜中  monochromeFilter.outputImage monochromeFilter滤镜处理完的图片
        blurFilter?.setValue(monochromeFilter?.outputImage, forKey: kCIInputImageKey)
        // 将处理好的图片输出
        let outCiImage: AnyObject? = blurFilter?.value(forKey: kCIOutputImageKey) as AnyObject
        // CIContext
        let context = CIContext(options: nil)
        // 获取CGImage句柄
        let outCGImage: CGImage = context.createCGImage(outCiImage! as! CIImage, from: outCiImage!.extent)!
        // 最终获取到图片
        let blurImage = UIImage(cgImage: outCGImage)
        return blurImage
    }
    
}

class YYFilterManager {
    
    static let shared: YYFilterManager = YYFilterManager()
    
    typealias FinishedHandler = (_ image: UIImage?, _ success: Bool) -> ()
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    func outputImage(originalImage: UIImage, type: FilterEnum, handler: @escaping FinishedHandler) {
        YYToast.ga.show()
        DispatchQueue.global(qos: .`default`).async {
            guard let filter = CIFilter(name: type.rawValue) else {
                DispatchQueue.main.async {
                    YYToast.ga.hide()
                    handler(nil, false)
                }
                return
            }
            let inputImage = CIImage(image: originalImage)
            filter.setValue(inputImage, forKey: kCIInputImageKey)
            guard let outputImage =  filter.outputImage else {
                DispatchQueue.main.async {
                    YYToast.ga.hide()
                    handler(nil, false)
                }
                return
            }
            guard let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent) else {
                DispatchQueue.main.async {
                    YYToast.ga.hide()
                    handler(nil, false)
                }
                return
            }
            DispatchQueue.main.async {
                YYToast.ga.hide()
                handler(UIImage(cgImage: cgImage), true)
            }
        }
    }
}

