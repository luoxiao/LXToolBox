//
//  UITextField+Ext.swift
//  BingoSudent
//
//  Created by xiao luo on 2019/12/25.
//  Copyright © 2019 Luo Xiao. All rights reserved.
//

import Foundation


public extension UITextField {
    
    convenience init(_ text:String, font:UIFont, textColor:UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.text = text
    }
    
    convenience init(_ font:UIFont, textColor:UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor;
    }
    
    convenience init(_ font:UIFont, textColor:UIColor, alignment:NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment
    }
    

    convenience init(_ font:UIFont, textColor:UIColor, horMargin:CGFloat, verMargin:CGFloat) {
        self.init()
        self.font = font
        self.textColor = textColor;
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: horMargin, height: 1))
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: horMargin, height: 1))
        self.rightViewMode = .always
        self.leftViewMode = .always
    }
    
    convenience init(_ font:UIFont, textColor:UIColor, leftMargin:CGFloat, rightMargin:CGFloat) {
        self.init()
        self.font = font
        self.textColor = textColor;
        if leftMargin > 0 {
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftMargin, height: 1))
            self.leftViewMode = .always
        }
        if rightMargin > 0 {
            self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: rightMargin, height: 1))
            self.rightViewMode = .always
        }
    }
    
    
    func placeholder(_ text:String, font:UIFont,textColor:UIColor ) {
        self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font:font, NSAttributedString.Key.foregroundColor:textColor])
    }
    
    
}
