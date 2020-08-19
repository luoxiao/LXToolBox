//
//  UIScrollView+Loading.swift
//  Pods
//
//  Created by luoxiao on 2020/7/14.
//

import Foundation

private var UICollectionViewLodingKey = 1238423
public extension UIScrollView {
    
    ///是否开始显示loading指示器（UIActivityIndicatorView）
    var isLoding:Bool {
        set {
            objc_setAssociatedObject(self, &UICollectionViewLodingKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            loadingViewStartAnimation(newValue)
        }
        get {
            if let value = objc_getAssociatedObject(self, &UICollectionViewLodingKey) as? Bool {
                return value
            }
            return false
        }
    }
    
    ///loading指示器Y轴偏移量
    func setLoadingOffsetY(_ offsetY:CGFloat) {
        guard let loadingView = self.viewWithTag(UICollectionViewLodingKey) as? UIActivityIndicatorView else {return}
        loadingView.snp.updateConstraints { (make) in
            make.centerY.equalToSuperview().offset(offsetY)
        }
    }
    
    private func loadingViewStartAnimation(_ animation:Bool) {
        var loadingView = self.viewWithTag(UICollectionViewLodingKey) as? UIActivityIndicatorView
        if loadingView == nil {
            loadingView = UIActivityIndicatorView()
            loadingView?.tag = UICollectionViewLodingKey
            loadingView!.hidesWhenStopped = true
            addSubview(loadingView!)
            loadingView!.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
        
        if animation {
            loadingView?.startAnimating()
        }
        else {
            loadingView?.stopAnimating()
        }
    }
}
