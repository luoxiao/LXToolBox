//
//  UITableViewCellExtension.swift
//  AiChain
//
//  Created by luoxiao on 2018/5/22.
//  Copyright © 2018年 AiChain. All rights reserved.
//

import Foundation

private let common_line_color  = UIColor.hex("#E8E8E8")

// line
extension UIView {
    
    @discardableResult
    func addBottomSeparatorLine(_ left:CGFloat? = 0,_ right:CGFloat? = 0, height:CGFloat? = 0.5) -> UIView {
        let line = UIView()
        let _left = left ?? CGFloat(0)
        let _right = right ?? CGFloat(0)
        let _height = height ?? CGFloat(0.3)
        self.addSubview(line)
        line.backgroundColor = common_line_color
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(_left)
            make.right.equalToSuperview().inset(_right)
            make.bottom.equalToSuperview()
            make.height.equalTo(_height)
        }
        return line
    }
    
    @discardableResult
    func addTopSeparatorLine(_ left:CGFloat? = 0,_ right:CGFloat? = 0, height:CGFloat? = 0.5) -> UIView {
        let line = UIView()
        let _left = left ?? CGFloat(0)
        let _right = right ?? CGFloat(0)
        let _height = height ?? CGFloat(0.3)
        self.addSubview(line)
        line.backgroundColor = common_line_color
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(_left)
            make.right.equalToSuperview().inset(_right)
            make.top.equalToSuperview()
            make.height.equalTo(_height)
        }
        return line
    }
    
    func addBottomSeparatorLine() {
        addBottomSeparatorLine(0, 0)
    }
    
    func addTopSeparatorLine() {
        addTopSeparatorLine(0, 0)
    }
    
    
    func addCellSeparatorLine(_ indexPath:IndexPath, height:CGFloat = 1,_ left:CGFloat,_ right:CGFloat) {
        if indexPath.row == 0 {
            addTopSeparatorLine(left, right, height: height)
            addBottomSeparatorLine(left, right, height: height)
        }
        else {
            addBottomSeparatorLine(left, right, height: height)
        }
    }
    
    func addCellSeparatorLine(indexPath:IndexPath) {
        addCellSeparatorLine(indexPath, 15, 15)
    }
    
    
    class func createLine() -> UIView {
        let line = UIView()
        line.backgroundColor = common_line_color
        return line
    }
    
    
}

extension UITableViewCell  {
    
    func superTableView() -> UITableView? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let tableView = view as? UITableView {
                return tableView
            }
        }
        return nil
    }    
}

