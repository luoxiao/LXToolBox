//
//  UIColor+Ext.swift
//  Utilities
//
//  Created by xiao luo on 2020/3/2.
//

import Foundation

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

public extension UIColor {
    
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {scanner.scanLocation = 1}
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
         
        let mask = 0x000000FF
        let r = CGFloat(Int(color >> 16) & mask) / 255.0
        let g = CGFloat(Int(color >> 8) & mask) / 255.0
        let b = CGFloat(Int(color) & mask) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
    
    class func hex(_ hex:String) -> UIColor {
        return UIColor(hex: hex)
    }
    
    class func hex(_ hex:String, alph:CGFloat) -> UIColor {
        return UIColor.hex(hex).withAlphaComponent(alph)
    }
    
    func alpha(_ alpha:CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
}
