//
//  UIImageExtension.swift
//  Bingo
//
//  Created by luoxiao on 2018/3/2.
//  Copyright © 2018年 EasyVaas. All rights reserved.
//

import Foundation
import UIKit


public extension UIImage {
    
    ///创建图片
    class func createWithColor(_ color:UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    ///创建渐变色图片
    class func createGradientWithColors(_ colors:[UIColor], _ startPoint: CGPoint, _ endPoint: CGPoint) -> UIImage {
        
        let emptyImage = UIImage()
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext(),
              let colorSpace = colors.last?.cgColor.colorSpace,
              let gradient = CGGradient(colorsSpace: colorSpace, colors: colors.map{$0.cgColor} as CFArray, locations: nil)
        else
        {
            return emptyImage
        }
        
        let nStart = CGPoint(x: rect.width * startPoint.x, y: rect.height * startPoint.y)
        let nEnd = CGPoint(x: rect.width * endPoint.x, y: rect.height * endPoint.y)

        context.saveGState()
        context.drawLinearGradient(gradient, start: nStart, end: nEnd, options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return emptyImage}
        UIGraphicsEndImageContext()
        return image
    }
    
    ///创建渐变色图片
    class func createGradientWithColors(_ colors:[UIColor]) -> UIImage {
        return UIImage.createGradientWithColors(colors, CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0))
    }
    
    ///View快照图片
    class func snapFromView(_ view:UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    ///加载原始图片，忽略tinkColor影响
    class func original(_ imageName:String) -> UIImage? {
        return UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
    }
    
    ///模糊图片
    class func coreBlurImage(_ img:UIImage,blur:Float) -> UIImage {
        let context = CIContext()
        let imputImg = CIImage(image: img)
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(imputImg, forKey: kCIInputImageKey)
        filter?.setValue(NSNumber(value: blur), forKey: "inputRadiusV")
        
        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage
        let outImage = context.createCGImage(result, from: result.extent)!
        let blurImage = UIImage(cgImage: outImage)
        return blurImage
    }
    

}


public extension UIImage {

    ///重置大小
    func reSizeImage(_ reSize:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    ///等比率缩放
    func scaleImage(_ scaleSize:CGFloat) -> UIImage? {
        let reSize = CGSize(width: size.width * scaleSize, height: size.height * scaleSize)
        return reSizeImage(reSize)
    }
    
    ///根据宽等比缩放
    func reSizeImageWidth(_ newWidth:CGFloat) -> UIImage? {
        let newHeight = newWidth / size.width * size.height
        let reSize = CGSize(width: newWidth, height: newHeight)
        return reSizeImage(reSize)
    }
    
    ///根据宽等比缩放
    func reSizeImageWidth(_ newWidth:CGFloat, quality:CGFloat) -> UIImage? {
        let newHeight = newWidth / size.width * size.height
        let reSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        guard let image = reSizeImage?.jpegData(compressionQuality: quality) else {return nil}
        return UIImage(data: image)
    }
    
    
    //KB
    class func compressImage(_ image:UIImage, aimKB:Int) -> UIImage {
        var data = image.jpegData(compressionQuality: 1)!
        if data.count < aimKB * 1024 {
            return image
        }
        
        var quality:CGFloat = 1
        while data.count > aimKB * 1024  && quality > 0.1 {
            quality -= 0.1
            data = image.jpegData(compressionQuality: quality)!
        }
        return UIImage(data: data)!;
    }
    
    //KB
    class func compressImageData(_ imgData:Data, aimKB:Int) -> Data {
        if imgData.count < aimKB * 1024 {
            return imgData
        }
        
        var quality:CGFloat = 0.8
        var data = imgData
        while data.count > aimKB * 1024 && quality > 0.1 {
            data = UIImage(data: imgData)!.jpegData(compressionQuality: quality)!
            quality -= 0.1
        }
        return data
    }
    
}


public extension UIImage {
    
    ///生成二维码
    class func generateQRCode(_ text: String,_ width:CGFloat,_ fillImage:UIImage? = nil, _ color:UIColor? = nil) -> UIImage? {
        
        guard let data = text.data(using: .utf8) else {return nil}
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            filter.setValue("H", forKey: "inputCorrectionLevel") // 设置生成的二维码的容错率 value = @"L/M/Q/H"
            guard let outPutImage = filter.outputImage else {return nil} //获取生成的二维码
            
            // 设置二维码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的二维码
            guard let newOutPutImage = colorFilter?.outputImage else {return nil}
            let scale = width/newOutPutImage.extent.width
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            let output = newOutPutImage.transformed(by: transform)
            let QRCodeImage = UIImage(ciImage: output)
            
            guard let fillImage = fillImage else {return QRCodeImage}
            let imageSize = QRCodeImage.size
            UIGraphicsBeginImageContext(imageSize)
            QRCodeImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            let fillRect = CGRect(x: (width - width/5)/2, y: (width - width/5)/2, width: width/5, height: width/5)
            fillImage.draw(in: fillRect)
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return QRCodeImage }
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
    
}

