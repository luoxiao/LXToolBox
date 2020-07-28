//
//  ActionSheet.swift
//  MiPan
//
//  Created by xiao luo on 2020/3/31.
//  Copyright © 2020 MiPan. All rights reserved.
//

import UIKit

private let ActionSheetPopView_item_height:CGFloat = 60
private let ActionSheetPopView_cancel_height:CGFloat = ActionSheetPopView_item_height + iPhoneXOffset
private let ActionSheetPopView_line_height:CGFloat = 0.5
private let ActionSheetPopView_section_space:CGFloat = 8


///外部调用
public extension ActionSheet {
    
    ///【纯文字】数组 + 默认取消
    class func show(_ titles:[String], click:ClickAction?, cancelAction:CancelAction?) {
        show(titles, click: click, cancelTitle: "取消", cancelAction: cancelAction)
    }
    
    ///【纯文字】数组 + 自定义取消
    class func show(_ titles:[String], click:ClickAction?, cancelTitle:String, cancelAction:CancelAction?) {
        show(titles.compactMap{ItemData($0)}, click: click, cancelItem: ItemData(cancelTitle), cancelAction: cancelAction)
    }
    
    ///【title+subTitle】数组 + 自定义动作
    class func showAll(_ items:[ItemData], clickAction:ClickAction?) {
        ActionSheetPopView.showAll(items, clickAction: clickAction)
    }
    
    ///【title+subTitle】数组 + 自定义取消 + 自定义动作
    class func show(_ items:[ItemData], click:ClickAction?, cancelItem:ItemData, cancelAction:CancelAction?) {
        var nItems = items
        nItems.append(cancelItem)
        showAll(nItems) { (index) in
            if index + 1 == nItems.count {
                cancelAction?()
            }
            else {
                click?(index)
            }
        }
    }
}

public class ActionSheet: NSObject
{
    public typealias CancelAction = ()->Void
    public typealias ConfirmAction = ()->Void
    public typealias ClickAction = (Int)->Void
    
    public struct ItemData {
        var title:String
        var subTitle:String?
        
        init(_ title:String) {
            self.title = title
        }
        
        init(_ title:String, subTitle:String) {
            self.title = title
            self.subTitle = subTitle
        }
    }

}

extension ActionSheetPopView {
    class func showAll(_ items:[ItemData], clickAction:ClickAction?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc = ActionSheetPopView(items, clickAction: clickAction)
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            UIViewController.top.present(vc, animated: true, completion: nil)
        }
    }
}

// View
class ActionSheetPopView: UIViewController {

    typealias ItemData = ActionSheet.ItemData
    typealias ClickAction = ActionSheet.ClickAction
    
    private let contentView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)

    var datas:[ItemData] = []
    var clickAction:ClickAction?
    var cancelAction:ClickAction?
    
    convenience init(_ items:[ItemData], clickAction:ClickAction?) {
        self.init()
        self.datas = items
        self.clickAction = clickAction
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.show(animated: true)
        }
    }
    
    fileprivate func initUI() {
        view.backgroundColor = UIColor.black.alpha(0.5)
        
        let cRect = CGRect(x: 0, y: 0, width: ScreenWidth, height: contentHeight())
        contentView.backgroundColor = .white
        let path = UIBezierPath(roundedRect: cRect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let mask = CAShapeLayer()
        mask.frame = cRect
        mask.path = path.cgPath
        contentView.layer.mask = mask
        view.addSubview(contentView)
        contentView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(self.contentHeight())
            make.top.equalTo(view.snp.bottom)
        }
        
        contentView.addSubview(tableView)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ActionSheetPopViewCell.self)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func contentHeight() -> CGFloat {
        var h = CGFloat((datas.count - 2)) * ActionSheetPopView_line_height + ActionSheetPopView_section_space
        h += CGFloat((datas.count - 1)) * ActionSheetPopView_item_height + ActionSheetPopView_cancel_height
        return h
    }
    
    func isBottomLastCell(_ indexPath:IndexPath) -> Bool {
        return indexPath.section + 1 == datas.count
    }
}

extension ActionSheetPopView:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isBottomLastCell(indexPath) {
            return ActionSheetPopView_cancel_height
        }
        return ActionSheetPopView_item_height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ActionSheetPopViewCell = tableView.dequeueReusableCell(indexPath)
        let item = datas[indexPath.section]
        cell.updateCellInfo(item.title, subTitle: item.subTitle)
        cell.isBottomLast = isBottomLastCell(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.clickAction?(indexPath.section)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        if section == 0 {
            
        }
        else if  section + 1 == datas.count {
            view.backgroundColor = .hex("#F0F0F0")
        }
        else {
            view.backgroundColor = UIColor.hex("#727272").alpha(0.2)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
        
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        else if  section + 1 == datas.count {
            return ActionSheetPopView_section_space
        }
        else {
            return 0.5
        }
    }
}


fileprivate extension ActionSheetPopView {
    
    func show(animated:Bool) {
        let duration:TimeInterval = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.snp.remakeConstraints { (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(self.contentHeight())
            }
            self.view.layoutIfNeeded()
        }) { (complete) in
            
        }
    }
    
    func dismiss(animated:Bool) {
        let duration:TimeInterval = animated ? 0.2 : 0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.snp.remakeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.height.equalTo(self.contentHeight())
                make.top.equalTo(self.view.snp.bottom)
            }
            self.view.layoutIfNeeded()
        }) { (complete) in
            self.dismiss(animated: animated, completion: nil)
        }
    }
}


extension ActionSheetPopView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == view {
            dismiss(animated: true)
        }
    }
}


fileprivate class ActionSheetPopViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    func updateCellInfo(_ title:String, subTitle:String?) {
        let att = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font:UIFont.size(16),NSAttributedString.Key.foregroundColor:UIColor.black])
        if let s = subTitle, s.count > 0 {
            let sAtt = NSAttributedString(string: "\n" + s, attributes: [NSAttributedString.Key.font:UIFont.size(10),NSAttributedString.Key.foregroundColor:UIColor.hex("#A5A5A5")])
            att.append(sAtt)
        }
        titleLabel.attributedText = att
    }
    
    var isBottomLast:Bool = false {
        didSet {
            updateLayout()
        }
    }
    
    func updateLayout()  {
        if isBottomLast {
            titleLabel.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().inset(20)
            }
        }
        else {
            titleLabel.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
    }
}
