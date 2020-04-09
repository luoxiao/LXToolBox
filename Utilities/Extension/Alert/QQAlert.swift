//
//  QQAlert.swift
//  BingoSudent
//
//  Created by xiao luo on 2020/2/12.
//  Copyright © 2020 Luo Xiao. All rights reserved.
//

import UIKit

class QQAlert: UIViewController {
    
    let contenView = UIView()
    let titleLabel = UILabel(.size(18), .hex("#4A4A4A"), 0)
    let subTitleLabel = UILabel(.size(13), .hex("4A4A4A"), 0)

    let cancelButton = UIButton(.size(14), .hex("585858"), .normal)
    let comfirmButton = UIButton(.size(14), .white, .normal)

    let statuIcon = UIImageView()
    
    var style:Style!
    
    typealias CancelAction = ()->Void
    typealias ConfirmAction = ()->Void
    
    var cancelBlock:CancelAction?
    var comfirmBlock:ConfirmAction?
    
    var viewModel = ViewModel()
    
    struct ViewModel {
        var title:String?
        var message:String?
        var cancelTitle:String?
        var comfirmTitle:String?
    }
    
    enum Style {
        case alert
        case warn
        case sucess
        case fail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        updateViewInfo()
    }
    
    
    func initUI() {
        
        view.backgroundColor = UIColor.black.alpha(0.5)
        view.addSubview(contenView)
        contenView.backgroundColor = .white
        contenView.layer.cornerRadius = 10
        contenView.clipsToBounds = true
        contenView.snp.makeConstraints { (make) in
            make.width.greaterThanOrEqualTo(260)
            make.width.lessThanOrEqualTo(320)
            make.center.equalToSuperview()
            make.height.greaterThanOrEqualTo(170)
            make.height.lessThanOrEqualTo(500)
        }
        
        if style == .alert {
            contenView.addSubview(titleLabel)
            titleLabel.textAlignment = .center
            titleLabel.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview().inset(32)
                make.top.equalToSuperview().inset(38)
            }
            
            contenView.addSubview(subTitleLabel)
            subTitleLabel.textAlignment = .center
            subTitleLabel.snp.makeConstraints { (make) in
                make.left.right.equalTo(titleLabel)
                make.top.equalTo(titleLabel.snp.bottom).offset(14)
            }
            
            contenView.addSubview(cancelButton)
            cancelButton.backgroundColor = .hex("#E6E6E6")
            cancelButton.layer.cornerRadius = 5
            cancelButton.clipsToBounds = true
            cancelButton.addTarget(self, action: #selector(cancelAction(_:)))
            
            contenView.addSubview(comfirmButton)
            comfirmButton.backgroundColor = .hex("#4DB871")
            comfirmButton.layer.cornerRadius = 5
            comfirmButton.clipsToBounds = true
            comfirmButton.addTarget(self, action: #selector(confirmAction(_:)))
            
            if let cance = viewModel.cancelTitle ,
                let comfirm = viewModel.comfirmTitle,
                cance.count > 0, comfirm.count > 0
            {
                cancelButton.snp.makeConstraints { (make) in
                    make.top.equalTo(subTitleLabel.snp.bottom).offset(28)
                    make.right.equalTo(contenView.snp.centerX).offset(-15)
                    make.bottom.equalToSuperview().inset(23)
                    make.width.greaterThanOrEqualTo(90)
                    make.height.equalTo(32)
                }
                
                comfirmButton.snp.makeConstraints { (make) in
                    make.size.centerY.equalTo(cancelButton)
                    make.left.equalTo(contenView.snp.centerX).offset(15)
                }
            }
            else {
                cancelButton.snp.makeConstraints { (make) in
                    make.width.greaterThanOrEqualTo(120)
                    make.height.equalTo(32)
                    make.top.equalTo(subTitleLabel.snp.bottom).offset(28)
                    make.bottom.equalToSuperview().inset(23)
                    make.centerX.equalToSuperview()
                }
                comfirmButton.snp.makeConstraints { (make) in
                    make.edges.equalTo(cancelButton)
                }
                
                cancelButton.isHidden = viewModel.cancelTitle == nil
                comfirmButton.isHidden = viewModel.comfirmTitle == nil
            }

        }
        else if style == .warn {
            
        }
        else if style == .sucess || style == .fail {
            statuIcon.image = style == .sucess ? UIImage(named: "icon_alert_success") : UIImage(named: "icon_alert_error")
            contenView.addSubview(statuIcon)
            statuIcon.clipsToBounds = true
            statuIcon.layer.cornerRadius = 52 / 2
            statuIcon.isUserInteractionEnabled = true
            statuIcon.snp.makeConstraints { (make) in
                make.size.equalTo(52)
                make.top.equalToSuperview().inset(40)
                make.centerX.equalToSuperview()
            }
            
            contenView.addSubview(titleLabel)
            titleLabel.textAlignment = .center
            titleLabel.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview().inset(32)
                make.top.equalTo(statuIcon.snp.bottom).offset(24)
                make.bottom.equalToSuperview().inset(37)
            }
        }
        
        
    }
    
    //Alert
    convenience init(title:String?, message:String?, cancelTitle:String?, comfirmTitle:String?) {
        self.init()
        self.style = .alert
        self.viewModel.title = title
        self.viewModel.message = message
        self.viewModel.cancelTitle = cancelTitle
        self.viewModel.comfirmTitle = comfirmTitle
    }
    

    private class func alert(_ title:String? = nil,
                     message:String? = nil,
                     cancelTitle:String? = nil,
                     comfirmTitle:String? = nil,
                     cancelAction:CancelAction? = nil,
                     confirmAction:ConfirmAction? = nil,
                     style:QQAlert.Style = .alert) -> QQAlert
    {
        let alertVC = QQAlert(title: title, message: message, cancelTitle: cancelTitle, comfirmTitle: comfirmTitle)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.cancelBlock = cancelAction
        alertVC.comfirmBlock = confirmAction
        UIViewController.top.present(alertVC, animated: true, completion: nil)
        return alertVC
    }
    
    
}

extension QQAlert {
    
    func updateViewInfo()  {
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.message
        cancelButton.setTitle(viewModel.cancelTitle, for: .normal)
        comfirmButton.setTitle(viewModel.comfirmTitle, for: .normal)
    }
}

extension QQAlert {
    
    @objc func cancelAction(_ sender:UIButton) {
        dismiss(animated: true) {
            if let block = self.cancelBlock {
                block()
            }
        }
    }
    
    @objc func confirmAction(_ sender:UIButton) {
        dismiss(animated: true) {
            if let block = self.comfirmBlock {
                block()
            }
        }
    }
    
}


extension QQAlert {
    
    @discardableResult
    public class func alertTitle(_ title:String) -> QQAlert {
        return QQAlert.alert(title, message: nil, cancelTitle: nil, comfirmTitle: "确定", cancelAction: nil, confirmAction: nil, style: .alert)
    }
    
    @discardableResult
    public class func alertTitle(_ title:String, message:String) -> QQAlert {
        return QQAlert.alert(title, message: message, cancelTitle: nil, comfirmTitle: "确定", cancelAction: nil, confirmAction: nil, style: .alert)
    }
    
    //以下为常用样式
    @discardableResult
    public class func alertTitle(_ title:String?, message:String?, cancelTitle:String, confirmTitle:String, action: ConfirmAction?) -> QQAlert {
        return QQAlert.alert(title, message: message, cancelTitle: cancelTitle, comfirmTitle: confirmTitle, cancelAction: nil, confirmAction: action, style: .alert)
    }
    
    @discardableResult
    public class func alertTitle(_ title:String?, message:String?, cancelTitle:String?, cancelAction:CancelAction?, confirmTitle:String, action:ConfirmAction?) -> QQAlert {
       return QQAlert.alert(title, message: message, cancelTitle: cancelTitle, comfirmTitle: confirmTitle, cancelAction: cancelAction, confirmAction: action, style: .alert)
    }
    
}
