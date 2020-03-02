//
//  UIColor+Ext.swift
//  Utilities
//
//  Created by xiao luo on 2020/3/2.
//

import Foundation

extension UIColor {

    public convenience init(hex hexValue: Int, alpha: CGFloat = 1.0) {
        let redValue   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let greenValue = CGFloat((hexValue & 0xFF00) >> 8) / 255.0
        let blueValue  = CGFloat(hexValue & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
    
    class func hex(_ hex:String) -> UIColor {
        var result: UInt32 = 0
        var h = hex
        if hex.hasPrefix("#") {
            h.remove(at: hex.startIndex)
        }
        Scanner(string: "0x" + hex).scanHexInt32(&result)
        return UIColor(hex: Int(result))
    }
    
    class func hex(_ hex:String, alph:CGFloat) -> UIColor {
        return UIColor.hex(hex).withAlphaComponent(alph)
    }
    
    func alpha(_ alpha:CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
}
