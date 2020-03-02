//
//  WKWebView+Ext.swift
//  BingoSudent
//
//  Created by xiao luo on 2020/1/14.
//  Copyright © 2020 Luo Xiao. All rights reserved.
//

import Foundation
import WebKit

public extension WKWebView {
    private struct key {
        static let scale = unsafeBitCast(Selector("scalesPageToFit"), to: UnsafePointer<Void>.self)
    }
    
    private var sourceOfUserScript: String {
        return "(function(){\n" +
            "    var head = document.getElementsByTagName('head')[0];\n" +
            "    var nodes = head.getElementsByTagName('meta');\n" +
            "    var i, meta;\n" +
            "    for (i = 0; i < nodes.length; ++i) {\n" +
            "        meta = nodes.item(i);\n" +
            "        if (meta.getAttribute('name') == 'viewport')  break;\n" +
            "    }\n" +
            "    if (i == nodes.length) {\n" +
            "        meta = document.createElement('meta');\n" +
            "        meta.setAttribute('name', 'viewport');\n" +
            "        head.appendChild(meta);\n" +
            "    } else {\n" +
            "        meta.setAttribute('backup', meta.getAttribute('content'));\n" +
            "    }\n" +
            "    meta.setAttribute('content', 'width=device-width, user-scalable=no');\n" +
        "})();\n"
    }
    
    var scalesPageToFit: Bool {
        get {
            return objc_getAssociatedObject(self, key.scale) != nil
        }
        set {
            if newValue {
                if objc_getAssociatedObject(self, key.scale) != nil {
                    return
                }
                let time = WKUserScriptInjectionTime.atDocumentEnd
                let script = WKUserScript(source: sourceOfUserScript, injectionTime: time, forMainFrameOnly: true)
                configuration.userContentController.addUserScript(script)
                objc_setAssociatedObject(self, key.scale, script, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                if url != nil {
                    evaluateJavaScript(sourceOfUserScript, completionHandler: nil)
                }
            } else if let script = objc_getAssociatedObject(self, key.scale) as? WKUserScript {
                objc_setAssociatedObject(self, key.scale, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                configuration.userContentController.removeUserScript(script: script)
                if url != nil {
                    let source = "(function(){\n" +
                        "    var head = document.getElementsByTagName('head')[0];\n" +
                        "    var nodes = head.getElementsByTagName('meta');\n" +
                        "    for (var i = 0; i < nodes.length; ++i) {\n" +
                        "        var meta = nodes.item(i);\n" +
                        "        if (meta.getAttribute('name') == 'viewport' && meta.hasAttribute('backup')) {\n" +
                        "            meta.setAttribute('content', meta.getAttribute('backup'));\n" +
                        "            meta.removeAttribute('backup');\n" +
                        "        }\n" +
                        "    }\n" +
                    "})();"
                    evaluateJavaScript(source, completionHandler: nil)
                }
            }
        }
    }
}
extension WKUserContentController {
    public func removeUserScript(script: WKUserScript) {
        let scripts = userScripts
        removeAllUserScripts()
        scripts.forEach {
            if $0 != script { self.addUserScript($0) }
        }
    }
}
