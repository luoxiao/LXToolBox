//
//  Defines.swift
//  AiChain
//
//  Created by luoxiao on 2018/5/9.
//  Copyright © 2018年 AiChain. All rights reserved.
//

import Foundation

let ScreenHeight = UIScreen.main.bounds.height
let ScreenWidth = UIScreen.main.bounds.width

let iPhoneXOffset = isPhoneX() ? CGFloat(24) : CGFloat(0)
let naviBarHeight = CGFloat(44 + 20 + isPhoneX().intValue * 24)
let tabBarHeight = CGFloat(49 + isPhoneX().intValue * 34)


func isPhoneX() -> Bool {
    var isIphoneX:Bool = false
    if #available(iOS 11.0, *) {
        if let window = UIApplication.shared.delegate?.window {
            isIphoneX = window!.safeAreaInsets.bottom > 0
        }
    }
    return isIphoneX
}
