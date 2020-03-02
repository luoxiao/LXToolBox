//
//  UITableViewExtension.swift
//  BingoSudent
//
//  Created by xiao luo on 2019/12/24.
//  Copyright © 2019 Luo Xiao. All rights reserved.
//

import Foundation

extension UITableView {
    
    func registerCell<T:UITableViewCell>(_ cellClass:T.Type) {
        register(cellClass, forCellReuseIdentifier: "\(T.self)")
    }
    
    func dequeueReusableCell<T:UITableViewCell>(_ indexPath:IndexPath) -> T {
        let identifier = "\(T.self)"
        if let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }
        else {
           return T.init(style: .default, reuseIdentifier: identifier)
        }
    }

    
}
