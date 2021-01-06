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
    
    mutating func saveRomve(_ index:Int) {
        if self.count > index {
            self.remove(at: index)
        }
    }

}


public extension Array where Element: Equatable {

    @discardableResult
    mutating func removeDuplicates() -> [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
        self = reduce(into: [Element]()) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
        return self
    }
}
