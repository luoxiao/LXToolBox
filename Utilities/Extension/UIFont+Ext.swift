//
//  UIFont+Ext.swift
//  Utilities
//
//  Created by xiao luo on 2020/3/2.
//

import Foundation
import UIKit

extension UIFont {
    
    class func size(_ size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    class func medium(_ size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
    
    class func bold(_ size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
    }

}
