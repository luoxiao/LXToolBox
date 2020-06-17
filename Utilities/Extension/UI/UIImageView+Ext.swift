//
//  UIImageView+Ext.swift
//  BingoSudent
//
//  Created by xiao luo on 2019/12/24.
//  Copyright © 2019 Luo Xiao. All rights reserved.
//

import Foundation
import Kingfisher

public extension UIImageView {
    
    convenience init(_ imageName:String) {
        self.init()
        self.isUserInteractionEnabled = true
        self.image = UIImage(named: imageName)
    }
    
    convenience init(_ imageName:String, taget:Any?, action:Selector?) {
        self.init()
        self.isUserInteractionEnabled = true
        self.image = UIImage(named: imageName)
        self.addGestureRecognizer(UITapGestureRecognizer(target: taget, action: action))
    }
    
}

public extension UIImageView {
    
    func setImage(_ url:String?) {
        setImage(url, placeholder: nil, failImage: nil)
    }
    
    func setImage(_ url:String?, placeholder:UIImage?) {
        setImage(url, placeholder: placeholder, failImage: nil)
    }
    
    func setImage(_ url:String?, placeholder:UIImage?, failImage:UIImage?) {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        if let u = url {
            self.kf.setImage(with: URL(string: u), placeholder: placeholder, options: [.transition(.fade(0.3))], progressBlock: nil) { [weak self]  (result) in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    if error.isInvalidResponseStatusCode {
                        self?.image = failImage
                    }
                }
            }
        }
    }
    
}
