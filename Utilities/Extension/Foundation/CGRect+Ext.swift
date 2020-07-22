//
//  CGRect+Ext.swift
//  Pods
//
//  Created by luoxiao on 2020/7/20.
//

import Foundation


public extension CGRect {
    
    var x:CGFloat {
        get {
            return self.origin.x
        }
        set {
            self = CGRect(x: newValue, y: self.origin.y, width: self.size.width, height: self.size.height)
        }
    }
    
    var y:CGFloat {
        get {
            return self.origin.y
        }
        set {
            self = CGRect(x: self.origin.x, y: newValue, width: self.size.width, height: self.size.height)
        }
    }
    
//    var width:CGFloat {
//        get {
//            return self.size.width
//        }
//        set {
//            self = CGRect(x: self.origin.x, y: self.origin.y, width: newValue, height: self.size.height)
//        }
//    }
//    
//    
//    var height:CGFloat {
//        get {
//            return self.size.height
//        }
//        set {
//            self = CGRect(x: self.origin.x, y: self.origin.y, width: self.size.width, height: newValue)
//        }
//    }
    
}
