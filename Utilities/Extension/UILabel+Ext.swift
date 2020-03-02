//
//  UILabelExtension.swift
//  BingoSudent
//
//  Created by xiao luo on 2019/12/24.
//  Copyright © 2019 Luo Xiao. All rights reserved.
//

import Foundation


public extension UILabel {
    
    convenience init(_ text:String, _ font:UIFont, _ textColor:UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.text = text
    }
    
    convenience init(_ font:UIFont, _ textColor:UIColor) {
        self.init()
        self.font = font
        self.textColor = textColor;
    }
    
    convenience init(_ font:UIFont, _ textColor:UIColor, _ textAlignment:NSTextAlignment) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    convenience init(_ font:UIFont, _ textColor:UIColor, _ numberOfLines:Int) {
        self.init()
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
    
}

///边距Label
class MMLabel: UILabel {
    
    var textInsets: UIEdgeInsets = .zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = textInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets),
                                  limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
}

