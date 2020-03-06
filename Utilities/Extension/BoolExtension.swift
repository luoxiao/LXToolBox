//
//  BoolExtension.swift
//  MiPan
//
//  Created by luoxiao on 2018/9/20.
//  Copyright © 2018年 MiPan. All rights reserved.
//

import Foundation

public extension Bool {
    
    var intValue:Int {
        get {
            return self ? 1 : 0
        }
    }
    
}
