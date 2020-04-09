//
//  UIViewExtension.swift
//  Bingo
//
//  Created by luoxiao on 2018/7/16.
//  Copyright © 2018年 EasyVaas. All rights reserved.
//

import Foundation
import UIKit


public extension UIView {
    
    
    //添加渐变色
    func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any]) {
        
        guard startPoint.x >= 0, startPoint.x <= 1, startPoint.y >= 0, startPoint.y <= 1, endPoint.x >= 0, endPoint.x <= 1, endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        
        layoutIfNeeded()
        var gradientLayer: CAGradientLayer!
        removeGradientLayer()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    
}

extension UIView {
    
    //绘制虚线
    public class func drawDashLine(color:UIColor,size:CGSize,lineWidth:CGFloat,space:CGFloat) ->UIImage? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(color.cgColor)
        context?.setLineWidth(size.height)
        context?.move(to: CGPoint(x: 0, y: 0))
        context?.addLine(to: CGPoint(x: size.width, y: 0))
        context?.setLineDash(phase: 0, lengths: [lineWidth,space])
        context?.drawPath(using: .stroke)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}

extension UIView {

    public func addShadowColor(_ color:UIColor, offset:CGSize? = .zero) {
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.white
        superview?.insertSubview(shadowView, belowSubview: self)
        shadowView.layer.shadowColor = color.cgColor;
        shadowView.layer.shadowOffset = offset ?? .zero
        shadowView.layer.shadowOpacity = 0.5;
        shadowView.layer.cornerRadius = self.layer.cornerRadius
        shadowView.clipsToBounds = false;
        shadowView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}

extension UIView {

    public func addTapTarget(_ target: Any?, action: Selector) {
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
}



