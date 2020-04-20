//
//  Alert.swift
//  BingoSudent
//
//  Created by xiao luo on 2019/12/29.
//  Copyright © 2019 Luo Xiao. All rights reserved.
//

import UIKit



public class Alert: NSObject {

    public typealias CancelAction = ()->Void
    public typealias ClickAction = (Int)->Void
    public typealias ConfirmAction = ()->Void

    
    private class func alert(_ title:String? = nil,
                     message:String? = nil,
                     cancelTitle:String? = nil,
                     cancelAction:CancelAction? = nil,
                     buttons:[String]? = [],
                     action:ClickAction? = nil,
                     confirmAction:ConfirmAction? = nil,
                     style:UIAlertController.Style = UIAlertController.Style.alert)
    {
        let alertCtr = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let cTitle = cancelTitle, cTitle.count > 0 {
            let cAction = UIAlertAction(title: cTitle, style: .cancel) { (act) in
                if let block = cancelAction {
                    block()
                }
            }
            alertCtr.addAction(cAction)
        }
        
        if let buttionTitles = buttons {
            for (index,title) in buttionTitles.enumerated() {
                let tAction = UIAlertAction(title: title, style: .default) { (alertAction) in
                    if let block = action {
                        block(index)
                    }
                    
                    if let block = confirmAction {
                        block()
                    }
                }
                alertCtr.addAction(tAction)
            }
        }

        UIViewController.top.present(alertCtr, animated: true, completion: nil)
    }
}


///Alert
extension Alert {
    
    public class func alertTitle(_ title:String) {
        Alert.alert(title, message: nil, cancelTitle: "确定", cancelAction: nil, buttons: nil, action: nil, style: .alert)
    }
    
    public class func alertTitle(_ title:String, message:String) {
        Alert.alert(title, message: message, cancelTitle: "确定", cancelAction: nil, buttons: nil, action: nil, style: .alert)
    }
    
    public class func alertMessage(message:String) {
        Alert.alert(nil, message: message, cancelTitle: "确定", cancelAction: nil, buttons: nil, action: nil, style: .alert)
    }
    
    ///只包含取消动作
    public class func alertTitle(_ title:String?, message:String?, cancelTitle:String, cancelAction:CancelAction?) {
        Alert.alert(title, message: message, cancelTitle: cancelTitle, cancelAction: cancelAction, buttons: nil, action: nil, style: .alert)
    }
    
    ///按钮数组动作，无取消
    public class func alertTitle(_ title:String?, message:String?, buttons:[String]?, action:ClickAction?) {
        Alert.alert(title, message: message, cancelTitle: nil, cancelAction: nil, buttons: buttons, action: action, style: .alert)
    }
    
    ///按钮数组动作，有取消
    public class func alertTitle(_ title:String?, message:String?, cancelTitle:String?, cancelAction:CancelAction?, buttons:[String]?, action:ClickAction?)
    {
        Alert.alert(title, message: message, cancelTitle: cancelTitle, cancelAction: cancelAction, buttons: buttons, action: action, style: .alert)
    }
    
    ///无取消、有确定
    public class func alertTitle(_ title:String?, message:String?, cancelTitle:String, confirmTitle:String, action:@escaping ConfirmAction) {
        Alert.alert(title, message: message, cancelTitle: cancelTitle, cancelAction: nil, buttons: [confirmTitle], confirmAction: action, style: .alert)
    }
    
    ///有取消、有确定
    public class func alertTitle(_ title:String?, message:String?, cancelTitle:String?, cancelAction:CancelAction?, confirmTitle:String, action:@escaping ConfirmAction) {
        Alert.alert(title, message: message, cancelTitle: cancelTitle, cancelAction: cancelAction, buttons: [confirmTitle], confirmAction: action, style: .alert)
    }

}

///ActionSheet
extension Alert {
    
    public class func actionSheetTitle(_ title:String) {
        Alert.alert(title, message: nil, cancelTitle: "确定", cancelAction: nil, buttons: nil, action: nil, style: .actionSheet)
    }
    
    public class func actionSheetTitle(_ title:String, message:String) {
        Alert.alert(title, message: message, cancelTitle: "确定", cancelAction: nil, buttons: nil, action: nil, style: .actionSheet)
    }
    
    public class func actionSheetMessage(message:String) {
        Alert.alert(nil, message: message, cancelTitle: "确定", cancelAction: nil, buttons: nil, action: nil, style: .actionSheet)
    }
    
    ///
    public class func actionSheetTitle(_ title:String, message:String, cancelTitle:String, cancelAction:CancelAction?) {
        Alert.alert(title, message: message, cancelTitle: cancelTitle, cancelAction: cancelAction, buttons: nil, action: nil, style: .actionSheet)
    }
    
    public class func actionSheetTitle(_ title:String, message:String, buttons:[String]?, action:ClickAction?) {
        Alert.alert(title, message: message, cancelTitle: nil, cancelAction: nil, buttons: buttons, action: action, style: .actionSheet)
    }
    
    public class func actionSheetTitle(_ title:String, message:String, cancelTitle:String?, cancelAction:CancelAction?, buttons:[String]?, action:ClickAction?)
    {
        Alert.alert(title, message: message, cancelTitle: cancelTitle, cancelAction: cancelAction, buttons: buttons, action: action, style: .actionSheet)
    }
}
