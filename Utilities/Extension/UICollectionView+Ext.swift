//
//  UICollectionView+Ext.swift
//  BingoSudent
//
//  Created by xiao luo on 2020/1/7.
//  Copyright © 2020 Luo Xiao. All rights reserved.
//

import Foundation


public extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: "\(T.self)")
    }
    
    public func register<T: UICollectionReusableView>(headerView viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(T.self)")
    }
    
    public func register<T: UICollectionReusableView>(footerView viewClass: T.Type) {
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(T.self)")
    }
    
    
    public func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let identifer = "\(T.self)"
        if let cell = dequeueReusableCell(withReuseIdentifier: identifer, for: indexPath) as? T {
            return cell
        }
        return dequeueReusableCell(for: indexPath)
    }
    
    public func dequeueReusableHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        let identifer = "\(T.self)"
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifer, for: indexPath) as! T
    }
    
    public func dequeueReusableFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        let identifer = "\(T.self)"
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifer, for: indexPath) as! T
    }
}


