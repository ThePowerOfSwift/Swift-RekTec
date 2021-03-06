//
//  LoginViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoginViewController: UIViewController, UITextFieldDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var remember_password: UISwitch!
    @IBOutlet weak var remember_password_label: UILabel!
    @IBOutlet weak var set_server: UIButton!
    
    var avatar: UIImageView!
    
    var serverAddress: ServerAddressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // components init
        setLoginAvatar()
        setUserNameTextField()
        setPasswordTextField()
        setRememberPassword()
        setServerAddress()
        setLoginButton()
        
        username.delegate = self
        password.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 初始化本地数据库
        MenusRepository.createParentMenusTable()
        MenusRepository.createChildMenusTable()
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
        // 字符串所占像素的大小
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
    
    // 设置服务器
    func setServerAddress(){
        let top = self.view.bounds.height / 4 + 40 + 60 + 10 + 60 + 20
        set_server.frame = CGRect.init(x: self.view.bounds.width - 100, y: top, width: 100, height: 20)
    }
    
    // 设置服务器
    @IBAction func set_server_click(_ sender: UIButton) {
        serverAddress = ServerAddressView(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), target: self)
        
        self.view.addSubview(serverAddress.View)
        self.serverAddress.View.frame.origin.y = self.view.bounds.height
        
        if #available(iOS 10.0, *) {
            let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeOut){
                self.serverAddress.View.frame.origin.y = 0
            }
            animator.startAnimation()
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                _ in
                self.serverAddress.View.frame.origin.y = 0
            })
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
        login_button.setTitleColor(UIColor.white, for: .disabled)
        
        login_button.setBackgroundImage(ImageUtils.imageWithColor(color: .white, rect: login_button.frame), for: .normal)
        login_button.setBackgroundImage(ImageUtils.imageWithColor(color: color, rect: login_button.frame), for: .selected)
        login_button.setBackgroundImage(ImageUtils.imageWithColor(color: color, rect: login_button.frame), for: .highlighted)
    }
    
    // 登录事件
    @IBAction func login_pressed(_ sender: UIButton) {
        startAnimating(CGSize.init(width: 30, height: 30), message: "正在登录...", type: .ballClipRotateMultiple, color: .gray, backgroundColor: .clear)
        
        self.login_button.isEnabled = false
        self.login_button.setTitle("正在登录...", for: .disabled)
        
        GlobalAppSetting.userName = self.username.text!
        let authUser = AuthenUser()
        authUser.Uid = username.text!
        // TODO 密码需要加密
        authUser.Pwd = password.text!
        
        AuthenticationService.loginCheck(authenUser: authUser, success: {response in
            GlobalAppSetting.password = self.password.text!
            
            if response["AuthToken"].stringValue.isEmpty || response["SystemUserId"].stringValue.isEmpty {
                self.login_button.isEnabled = true
                self.login_button.setTitle("登录", for: .normal)
                return
            }
            
            GlobalAppSetting.xrmAuthToken = response["AuthToken"].stringValue
            GlobalAppSetting.systemUserId = response["SystemUserId"].stringValue
            GlobalAppSetting.isFirstOpen = response["IsLoginFirst"].boolValue
            
            // TODO 推送注册
            
            // 更新头像
            self.login_button.setTitle("正在更新头像...", for: .disabled)
            UserService.getUserAvatarFromCloud(systemUserId: GlobalAppSetting.systemUserId)
            
//            Thread.sleep(forTimeInterval: 3)
            
            self.stopAnimating()
            GlobalAppSetting.xrmWebApiBaseUrl = "http://192.168.1.232:7777/"
            self.performSegue(withIdentifier: "login_segue", sender: nil)
            
            self.login_button.isEnabled = true
            self.login_button.setTitle("登录", for: .normal)
        }, failure: {response in
            self.stopAnimating()
            // TODO登录失败处理
            print(response)
            self.login_button.isEnabled = true
            self.login_button.setTitle("登录", for: .normal)
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
