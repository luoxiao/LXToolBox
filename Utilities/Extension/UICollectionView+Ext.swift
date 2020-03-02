//
//  UICollectionView+Ext.swift
//  BingoSudent
//
//  Created by xiao luo on 2020/1/7.
//  Copyright © 2020 Luo Xiao. All rights reserved.
//

import Foundation


extension UICollectionView {
    
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


private var UICollectionViewisLodingKey = 102
extension UIScrollView:DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    
    var isLoding:Bool {
        set {
            objc_setAssociatedObject(self, &UICollectionViewisLodingKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            reloadEmptyDataSet()
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, &UICollectionViewisLodingKey) as? Bool {
                return rs
            }
            return false
        }
    }
    
    func emptySelf() {
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        self.isLoding = true
    }
    
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoding = false
        }
        if self.isLoding {
            return UIImage(named: "icon_nodata_fail")
        }
        else {
            return UIImage(named: "icon_nodata")
        }
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if self.isLoding {
            return NSAttributedString(string: "加载中...", attributes: [NSAttributedString.Key.font:UIFont.medium(15), NSAttributedString.Key.foregroundColor:UIColor.titleColor])
        }
        else {
            return NSAttributedString(string: "暂无数据", attributes: [NSAttributedString.Key.font:UIFont.medium(15), NSAttributedString.Key.foregroundColor:UIColor.titleColor])
        }
    }
    
    public func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return self.isLoding
    }
    
    public func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = NSNumber(value: 0.95)
        animation.toValue = NSNumber(value: 1.05)
        animation.duration = 0.5;
        animation.autoreverses = true
        animation.timingFunction = .init(name: .easeOut)
        animation.repeatCount = .greatestFiniteMagnitude;
        return animation;
        
    }
    
}

