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
    
    
    class func snapFromView(_ view:UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func original(_ imageName:String) -> UIImage? {
        return UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
    }
    
    
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
    
    
    func reSizeImage(_ reSize:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale);
        draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    //等比率缩放
    func scaleImage(_ scaleSize:CGFloat) -> UIImage? {
        let reSize = CGSize(width: size.width * scaleSize, height: size.height * scaleSize)
        return reSizeImage(reSize)
    }
    
    //根据宽等比缩放
    func reSizeImageWidth(_ newWidth:CGFloat) -> UIImage? {
        let newHeight = newWidth / size.width * size.height
        let reSize = CGSize(width: newWidth, height: newHeight)
        return reSizeImage(reSize)
    }
    
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
    
    //生成二维码
    class func generateQRCode(_ str: String) -> UIImage? {
        let data = str.data(using: .ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 9, y: 9)
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        return UIImage(ciImage: output)
    }
    
}
