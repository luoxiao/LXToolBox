//
//  NSButtonExtension.swift
//  AiChain
//
//  Created by luoxiao on 2018/6/7.
//  Copyright © 2018年 AiChain. All rights reserved.
//

import Foundation

public extension UIButton {
   
    convenience init(_ font:UIFont, _ textColor:UIColor, _ state:UIControl.State) {
        self.init(type: .system)
        self.setTitleColor(textColor, for: state)
        self.titleLabel?.font = font
    }
    
    convenience init(_ title:String, _ font:UIFont, _ textColor:UIColor, _ state:UIControl.State) {
        self.init(type: .system)
        self.setTitleColor(textColor, for: state)
        self.titleLabel?.font = font
        self.setTitle(title, for: state)
    }
    
    convenience init(_ font:UIFont, _ textColor:UIColor,  _ image:UIImage?, _ state:UIControl.State) {
        self.init(type: .system)
        self.setImage(image?.withRenderingMode(.alwaysOriginal), for: state)
        self.setTitleColor(textColor, for: state)
        self.titleLabel?.font = font
    }
    
    convenience init(_ font:UIFont, _ textColor:UIColor, _ backgroundColor:UIColor?, _ state:UIControl.State) {
        self.init(type: .system)
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: state)
        self.titleLabel?.font = font
    }

    convenience init(_ imageName:String, _ state:UIControl.State) {
        self.init(type: .system)
        self.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: state)
    }
    
    
    func addTarget(_ target: Any?, action: Selector) {
        self.addTarget(target, action: action, for: .touchUpInside)
    }
        
}

public extension UIButton {
    func c(_ textColor:UIColor, _ font:UIFont, _ state:UIControl.State) {
        setTitleColor(textColor, for: state)
        titleLabel?.font = font
    }
    
    func c(_ textColor:UIColor, _ font:UIFont,_ imageName:String ,_ state:UIControl.State) {
        setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: state)
        setTitleColor(textColor, for: state)
        titleLabel?.font = font
    }
}

public extension UIButton {
    
    func setImage(_ url:String?) {
        if let u = url, let url = URL(string: u) {
            self.kf.setImage(with: url, for: .normal, placeholder: nil, options: [.transition(.fade(0.3))])
        }
    }
}
