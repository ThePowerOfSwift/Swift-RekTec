//
//  ServerAddressController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/14.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class ServerAddressView{
    
    private var view: UIView
    
    init(frame: CGRect, target: Any?, action: Selector) {
        self.view = UIView.init(frame: frame)
        self.view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.6)
        
        let closeButton = UIButton.init(frame: CGRect.init(x: 20, y: 20, width: 40, height: 40))
//        closeButton.setTitle("Close", for: .normal)
        closeButton.backgroundColor = .black
//        let color = UIColor.init(red: 0, green: 153 / 255, blue: 1, alpha: 1)
//        closeButton.setTitleColor(color, for: .normal)
//        closeButton.setTitleColor(UIColor.white, for: .selected)
//        closeButton.setTitleColor(UIColor.white, for: .highlighted)
//        closeButton.setTitleColor(UIColor.white, for: .disabled)
        closeButton.addTarget(target, action: action, for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        let textField = UITextField.init(frame: CGRect.init(x: 10, y: frame.height / 2 - 40, width: frame.width - 20, height: 40))
        textField.text = GlobalAppSetting.xrmWebApiBaseUrl
        textField.backgroundColor = .white
        textField.leftViewMode = .always
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textAlignment = .left
        textField.placeholder = "服务器地址"
        let textFieldLeftView = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width / 6, height: 40))
        textFieldLeftView.text = "URL"
        textFieldLeftView.textColor = .gray
        textFieldLeftView.textAlignment = .center
        textField.leftView = textFieldLeftView
        textField.addTarget(self, action: #selector(saveServerAddress(_:)), for: UIControlEvents.editingChanged)
        self.view.addSubview(textField)
        
        let tapGesture = UITapGestureRecognizer (target: self , action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
    }
    
    @objc func saveServerAddress(_ sender: UITextField){
        if !sender.text!.isEmpty {
            GlobalAppSetting.xrmWebApiBaseUrl = sender.text!
        }
    }
    
    var View: UIView{
        get{
            return self.view
        }
    }
}
