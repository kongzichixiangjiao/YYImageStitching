//
//  YYFilterModel.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/7.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import HandyJSON

enum YYFilterType: String {
    case saturation = "饱和度", contrast = "对比度", brightness = "亮度", exposure = "曝光", RGBGreen = "RGB绿", RGBRed = "RGB红", RGBBlue = "RGB蓝", vignette = "晕映-暗角", Hue = "色度", monochrome = "单色", sharpen = "锐化", Gamma = "灰度系数", toneCurve = "色调曲线", sepiaTone = "褐色（怀旧）", Amotorka = "Amatorka lookup", MissEtikate = "MissEtikate lookup", SoftElegance = "Soft elegance lookup", ColorInvert = "反色", Grayscale = "灰度", Threshold = "阀值素描，形成有噪点的素描", Sketch = "素描", Toon = "卡通效果（黑色粗线描边）", SmoothToon = "卡通效果", Posterize = "色调分离", Emboss = "浮雕效果", GaussianBlur = "高斯模糊", iOSBlur = "iOS模糊", ZoomBlur = "变焦模糊", BoxBlur = "盒子模糊", MotionBlur = "运动模糊", Bilateral = "双边模糊", Swirl = "漩涡", Bulge = "鱼眼效果", Pinch = "凹面镜", SphereRefraction = "球形折射", GlassSphere = "水晶球效果", Stretch = "哈哈镜", Dilation = "扩展模糊", Eosion = "侵蚀模糊",
    
    Multiply = "阴影效果", Normal = "正常", Alpha = "透明混合", Overlay = "叠加", Dissolve = "溶解", Darken = "加深混合", Lighten = "减淡混合", SourceOver = "源混合", ColorBurn = "色彩加深混合", ColorDodge = "色彩减淡混合", Exclusion = "排除混合", Difference = "差异混合", Subtract = "差值混合", HardLight = "强光混合", SoftLight = "柔光混合", ChromaKey = "色度键混合", Mask = "遮罩混合", Haze = "朦胧加暗", LuminanceThreshold = "亮度阈", AdaptiveThreshold = "自适应阈值", Add = "变亮模糊效果", Divide = "变暗模糊效果",
    
    colormatrix_heibai = "黑白", colormatrix_lomo = "LOMO", colormatrix_huajiu = "复古", colormatrix_gete = "哥特", colormatrix_ruihua = "锐化new", colormatrix_danya = "淡雅", colormatrix_jiuhong = "酒红", colormatrix_qingning = "清宁", colormatrix_langman = "浪漫", colormatrix_guangyun = "光晕", colormatrix_landiao = "蓝调", colormatrix_menghuan = "梦幻", colormatrix_yese = "夜色", colormatrix_test = "test"
}



class YYFilterModel: HandyJSON {
    var type: String = ""
    var describe: String = ""
    var sliderMinValue: Float = 0
    var sliderMaxValue: Float = 0
    var sliderCurrentValue: Float = 0
    var isSelected: Bool = false 
    var thumbnailImage: UIImage?
    
    required init() {
        
    }
}
