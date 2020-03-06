//
//  Array+Extension.swift
//  CamScanner
//
//  Created by xiao luo on 2018/11/14.
//  Copyright © 2018 Gragrance. All rights reserved.
//

import Foundation


public extension Array {
    
    subscript (safe index:Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
    func objectAtIndex(_ index:Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
    
}
