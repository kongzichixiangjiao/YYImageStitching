//
//  YYFilterHelper.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/12.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

/*
 let p = colormatrix_landiao.withUnsafeMutableBufferPointer() {
 // 这里，形参是一个含有一个UnsafeMutableBufferPointer的形参，
 // 返回类型为UnsafeMutablePointer的函数类型。
 (buffer: inout UnsafeMutableBufferPointer<Float>) -> UnsafeMutablePointer<Float> in
 return buffer.baseAddress!
 }
 */

extension UIImage {
    // 返回一个使用RGBA通道的位图上下文
    @objc func createRGBABitmapContext (inImage: CGImage) -> CGContext {
        var context: CGContext!
        
        var colorSpace: CGColorSpace!
        var bitmapByteCount: Int!
        var bitmapBytesPerRow: Int!
        
        let pixelsWide: size_t = inImage.width //获取横向的像素点的个数
        let pixelsHigh: size_t = inImage.height //纵向
        
        bitmapBytesPerRow = pixelsWide * 4 //每一行的像素点占用的字节数，每个像素点的ARGB四个通道各占8个bit(0-255)的空间
        bitmapByteCount = bitmapBytesPerRow * pixelsHigh //计算整张图占用的字节数
        
        colorSpace = CGColorSpaceCreateDeviceRGB() //创建依赖于设备的RGB通道
        //内存空间的指针，该内存空间的大小等于图像使用RGB通道所占用的字节数。
        let bitmapData = malloc(bitmapByteCount) //分配足够容纳图片字节数的内存空间
        
        //创建CoreGraphic的图形上下文，该上下文描述了bitmaData指向的内存空间需要绘制的图像的一些绘制参数
        context = CGContext(data: bitmapData, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8, bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        return context
    }
    
    func requestImagePixelData(inImage: UIImage) -> UnsafeMutableRawPointer?
        // 返回一个指针，该指针指向一个数组，数组中的每四个元素都是图像上的一个像素点的RGBA的数值(0-255)，用无符号的char是因为它正好的取值范围就是0-255
    {
        guard let img = inImage.cgImage else {
            return nil
        }
        let size = inImage.size
        
        let cgctx = createRGBABitmapContext(inImage: img) //使用上面的函数创建上下文
        
        let rect = CGRect(x: 0, y: 0, width: size.width * inImage.scale, height: size.height * inImage.scale)
        //将目标图像绘制到指定的上下文，实际为上下文内的bitmapData。
        cgctx.draw(img, in: rect)
        let data = cgctx.data
        print(data)
        return data
    }
    
    //修改RGB的值
    func changeRGBA(red: Int, green: Int, blue: Int, alpha: Int, colorMatrix f: UnsafeMutablePointer<Float>) -> [Int]
    {
        var newRed = f[0] * red.float + f[1] * green.float + f[2] * blue.float + f[3] * alpha.float + f[4]
        var newGreen = f[0+5] * red.float + f[1+5] * green.float + f[2+5] * blue.float + f[3+5] * alpha.float + f[4+5];
        var newBlue = f[0+5*2] * red.float + f[1+5*2] * green.float + f[2+5*2] * blue.float + f[3+5*2] * alpha.float + f[4+5*2];
        var newAlpha = f[0+5*3] * red.float + f[1+5*3] * green.float + f[2+5*3] * blue.float + f[3+5*3] * alpha.float + f[4+5*3];
        
        if (newRed > 255)
        {
            newRed = 255
        }
        if(newRed < 0)
        {
            newRed = 0
        }
        if (newGreen > 255)
        {
            newGreen = 255
        }
        if (newGreen < 0)
        {
            newGreen = 0
        }
        if (newBlue > 255)
        {
            newBlue = 255
        }
        if (newBlue < 0)
        {
            newBlue = 0
        }
        if (newAlpha > 255)
        {
            newAlpha = 255
        }
        if (newAlpha < 0)
        {
            newAlpha = 0
        }
        return [Int(newRed), Int(newGreen), Int(newBlue), Int(newAlpha)]
    }
    
    func yy_image(colorMatrix: UnsafeMutablePointer<Float>) -> UIImage
    {
        let data = requestImagePixelData(inImage: self)
        let imgPixel = data?.assumingMemoryBound(to: u_char.self)
        
        let inImageRef = self.cgImage
        let w = inImageRef?.width
        let h = inImageRef?.height
        
        var wOff: Int = 0
        var pixOff: Int = 0
        
        //双层循环按照长宽的像素个数迭代每个像素点
        for _ in 0..<h!
        {
            pixOff = wOff
            
            for _ in 0..<w!
            {
                let red = u_char(imgPixel![pixOff])
                let green = u_char(imgPixel![pixOff + 1])
                let blue = u_char(imgPixel![pixOff + 2])
                let alpha = u_char(imgPixel![pixOff + 3])
                
                let arr = changeRGBA(red: Int(red), green: Int(green), blue: Int(blue), alpha: Int(alpha), colorMatrix: colorMatrix)
                
                //回写数据
                imgPixel![pixOff] = u_char(arr[0])
                imgPixel![pixOff+1] = u_char(arr[1])
                imgPixel![pixOff+2] = u_char(arr[2])
                imgPixel![pixOff+3] = u_char(arr[3])
                
                pixOff += 4 //将数组的索引指向下四个元素
            }
            
            wOff += w! * 4
        }
        
        let dataLength = w! * h! * 4
        
        //下面的代码创建要输出的图像的相关参数
        let provider = CGDataProvider.init(dataInfo: nil, data: imgPixel!, size: dataLength) {_,_,_ in
            
        }
        
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        let bytesPerRow = 4 * w!
        let colorSpaceRef = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo.byteOrderMask
        let renderingIntent = CGColorRenderingIntent.defaultIntent
        
        
        let imageRef = CGImage(width: w!, height: h!, bitsPerComponent: bitsPerComponent, bitsPerPixel: bitsPerPixel, bytesPerRow: bytesPerRow,space: colorSpaceRef, bitmapInfo: bitmapInfo, provider: provider!, decode: nil, shouldInterpolate: false, intent: renderingIntent)
        
        let myImage = UIImage(cgImage: imageRef!)
        
        return myImage;
    }
    
}
