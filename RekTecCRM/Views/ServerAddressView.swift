//
//  ServerAddressController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/14.
//  Copyright © 2017年 Channing Kuo. All rights reserved..
//

import UIKit

class ServerAddressView{
    
    private var view: UIView
    private var textField: UITextField
    
    init(frame: CGRect, target: Any?) {
        self.view = UIView.init(frame: frame)
        self.view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        
        textField = UITextField.init(frame: CGRect.init(x: 10, y: frame.height / 2 - 40, width: frame.width - 20, height: 40))
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
        
        if #available(iOS 10.0, *) {
            textField.frame.origin.x = -frame.width
            textField.alpha = 0
            let animator = UIViewPropertyAnimator(duration: 0.3, dampingRatio: 0.4){
                self.textField.alpha = 1
                self.textField.frame.origin.x = 10
            }
            animator.startAnimation(afterDelay: 0.4)
        } else {
            // Fallback on earlier versions
        }
        
        let tapGesture = UITapGestureRecognizer (target: self , action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard(){
        self.view.endEditing(true)
        
        if #available(iOS 10.0, *) {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut){
                self.view.frame.origin.x = self.view.bounds.width
                self.view.frame.origin.y = self.view.bounds.height
            }
            animator.addCompletion { (position) in
                self.view.removeFromSuperview()
            }
            animator.startAnimation()
        } else {
            // Fallback on earlier versions
        }
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
