//
//  LoginViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var remember_password: UISwitch!
    @IBOutlet weak var remember_password_label: UILabel!
    
    var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // components init
        setLoginAvatar()
        setUserNameTextField()
        setPasswordTextField()
        setRememberPassword()
        setLoginButton()
        
        username.delegate = self
        password.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // sqlitedb测试
        var dataInfoTable = [ColumnType]()
        let col1 = ColumnType(colName: "caption", colType: "varchar(100)", colValue: nil)
        let col2 = ColumnType(colName: "account", colType: "varchar(100)", colValue: nil)
        let col3 = ColumnType(colName: "password", colType: "varchar(100)", colValue: nil)
        let col4 = ColumnType(colName: "iconName", colType: "varchar(100)", colValue: nil)
        let col5 = ColumnType(colName: "lastEditTime", colType: "datetime", colValue: nil)
        let col6 = ColumnType(colName: "remark", colType: "varchar(200)", colValue: nil)
        let col7 = ColumnType(colName: "key", colType: "varchar(100) not null", colValue: nil)
        let col8 = ColumnType(colName: "indexKey", colType: "int not null", colValue: nil)
        dataInfoTable += [col1, col2, col3, col4, col5, col6, col7, col8]
        SQliteRepository.createTable(tableName: SQliteRepository.PASSWORDINFOTABLE, columns: dataInfoTable)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    // 点击view上空白的地方收起键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 处理键盘遮挡输入框的问题
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let frame = textField.frame
        var keyboardHeight: CGFloat = 216.0
        if textField == username {
            keyboardHeight += 40
        }
        // 计算键盘是否遮挡输入框
        let offset = frame.origin.y + 60 - (self.view.frame.size.height - keyboardHeight)
        
        if offset > 0 {
            UIView.beginAnimations("ResizeForKeyboard", context: nil)
            UIView.setAnimationDuration(0.30)
            
            self.view.frame = CGRect.init(x: 0.0, y: -offset, width: self.view.frame.size.width, height: self.view.frame.size.height)
            
            UIView.commitAnimations()
        }
    }
    
    // 收起键盘时恢复view
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    // return键点击事件控制
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == username {
            password.becomeFirstResponder()
        }
        else if textField == password {
            self.login_pressed(login_button)
        }
        return true
    }

//    func launchAnimation(){
//        let viewController = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
//        let vc = viewController.instantiateViewController(withIdentifier: "LaunchScreen")
//        let launchView = vc.view
//        let mainWindow = UIApplication.shared.keyWindow
//        launchView?.frame = (UIApplication.shared.keyWindow?.frame)!
//        mainWindow?.addSubview(launchView!)
//        
//        UIView.animate(withDuration: 1.0, delay: 0.5, options: .beginFromCurrentState, animations: {
//            launchView?.alpha = 0.0
//            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
//        }, completion: {
//            (finished: Bool) -> Void in
//            launchView?.removeFromSuperview()
//        })
//    }
    
    // avatar设置
    func setLoginAvatar(){
        let left = (self.view.bounds.width - 80) / 2
        let top = (self.view.bounds.height / 4 - 80) / 2 + 20
        avatar = UIImageView.init(frame: CGRect.init(x: left, y: top, width: 80, height: 80))
        
        avatar.image = UserService.getUserAvatarFromCacheOrDefault(systemUserId: GlobalAppSetting.systemUserId)
        
        avatar.contentMode = .scaleAspectFit
        avatar.layer.borderColor = UIColor.init(red: 0, green: 153 / 255, blue: 1, alpha: 1).cgColor
        avatar.layer.borderWidth = 0.5
        avatar.layer.cornerRadius = 40
        avatar.layer.masksToBounds = true
        self.view.addSubview(avatar)
        
        let avatar_layer = CALayer.init()
        avatar_layer.position = avatar.layer.position
        avatar_layer.bounds = avatar.bounds
        avatar_layer.cornerRadius = avatar.layer.cornerRadius
        avatar_layer.backgroundColor = UIColor.white.cgColor
        avatar_layer.shadowColor = UIColor.init(red: 0, green: 153 / 255, blue: 1, alpha: 1).cgColor
        avatar_layer.shadowRadius = 10
        avatar_layer.shadowOffset = CGSize.init(width: 0, height: 0)
        avatar_layer.shadowOpacity = 0.5
        self.view.layer.addSublayer(avatar_layer)
        self.view.bringSubview(toFront: avatar)
    }
    
    // 用户名设置
    func setUserNameTextField(){
        let width = self.view.bounds.width - 40
        let height = 60
        let top = self.view.bounds.height / 4 + 40
        username.frame = CGRect.init(x: 20, y: Int(top), width: Int(width), height: height)
        
        username.placeholder = "请输入用户名"
        username.adjustsFontSizeToFitWidth = true
        username.font = UIFont.boldSystemFont(ofSize: 14)
        
        let icon = UIImageView.init(frame: CGRect.init(x: 0, y: 20, width: 20, height: 20))
        icon.image = UIImage.init(named: "login_user.png")
        username.leftViewMode = .always
        username.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 60))
        username.leftView?.addSubview(icon)

        username.text = GlobalAppSetting.userName
        
        
        let border = UIView.init(frame: CGRect.init(x: 20, y: top + 60, width: width, height: 1))
        border.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        self.view.addSubview(border)
    }
    
    @IBAction func usernameTextFidldChanged(_ sender: UITextField) {
        if GlobalAppSetting.isRememberPassword {
            password.text = username.text != GlobalAppSetting.userName ? "" : GlobalAppSetting.password
        }
    }
    // 密码设置
    func setPasswordTextField(){
        let width = self.view.bounds.width - 40
        let height = 60
        let top = self.view.bounds.height / 4 + 40 + 60 + 10
        password.frame = CGRect.init(x: 20, y: Int(top), width: Int(width), height: height)
        
        password.placeholder = "请输入密码"
        password.adjustsFontSizeToFitWidth = true
        password.font = UIFont.boldSystemFont(ofSize: 14)
        
        let icon = UIImageView.init(frame: CGRect.init(x: 0, y: 20, width: 20, height: 20))
        icon.image = UIImage.init(named: "login_password.png")
        password.leftViewMode = .always
        password.leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 60))
        password.leftView?.addSubview(icon)
        
        password.text = GlobalAppSetting.password
        
        let border = UIView.init(frame: CGRect.init(x: 20, y: top + 60, width: width, height: 1))
        border.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        self.view.addSubview(border)
    }
    
    // 记住密码
    func setRememberPassword(){
        let top = self.view.bounds.height / 4 + 40 + 60 + 10 + 60 + 20
        let textString = remember_password_label.text
        let size = textString?.size(attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
        
        remember_password_label.frame = CGRect.init(x: 20, y: top, width: size!.width, height: 20)
        remember_password_label.font = UIFont.boldSystemFont(ofSize: 12)
        remember_password_label.textColor = UIColor.init(red: 112 / 255, green: 128 / 255, blue: 144 / 255, alpha: 1)
        
        remember_password.frame.origin.x = size!.width + 20
        remember_password.frame.origin.y = top - 5
        remember_password.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        remember_password.setOn(GlobalAppSetting.isRememberPassword, animated: true)
    }
    
    // 记住密码切换
    @IBAction func rememberSwitchChange(_ sender: UISwitch) {
        GlobalAppSetting.isRememberPassword = sender.isOn
        if !GlobalAppSetting.isRememberPassword {
            GlobalAppSetting.password = ""
        }
    }
    // 登录按钮
    func setLoginButton(){
        let left = (self.view.bounds.width - 135) / 2
        let top = self.view.bounds.height / 4 + 40 + 60 + 10 + 60 + 20 + 60
        login_button.frame = CGRect.init(x: left, y: top, width: 135, height: 35)
        login_button.layer.borderColor = UIColor.init(red: 0, green: 153 / 255, blue: 1, alpha: 1).cgColor
        login_button.layer.borderWidth = 0.5
        login_button.layer.cornerRadius = 5
        let color = UIColor.init(red: 0, green: 153 / 255, blue: 1, alpha: 1)
        login_button.setTitleColor(color, for: .normal)
        login_button.setTitleColor(UIColor.white, for: .selected)
        login_button.setTitleColor(UIColor.white, for: .highlighted)
        
        login_button.setBackgroundImage(ImageUtils.imageWithColor(color: .white, rect: login_button.frame), for: .normal)
        login_button.setBackgroundImage(ImageUtils.imageWithColor(color: color, rect: login_button.frame), for: .selected)
        login_button.setBackgroundImage(ImageUtils.imageWithColor(color: color, rect: login_button.frame), for: .highlighted)
    }
    
    // 登录事件
    @IBAction func login_pressed(_ sender: UIButton) {
        AuthenticationService.loginCheck(authenUser: nil, success: {reponse in
            GlobalAppSetting.userName = self.username.text!
            GlobalAppSetting.password = self.password.text!
            self.performSegue(withIdentifier: "login_segue", sender: nil)
        }, failure: {reponse in
            // TODO登录失败处理
        })
    }
    
    
    // 在这个方法中可以给TabBarController页面传递参数
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "login_segue"{
//            let controller = segue.destination as! DetailViewController
//            controller.itemString = sender as? String
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
