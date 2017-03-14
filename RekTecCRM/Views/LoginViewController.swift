//
//  LoginViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var remember_password: UISwitch!
    @IBOutlet weak var remember_password_label: UILabel!
    
    var avatar: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init
        setLoginAvatar()
        setUserNameTextField()
        setPasswordTextField()
        setRememberPassword()
        setLoginButton()
    }
    
    // avatar设置
    func setLoginAvatar(){
        let left = (self.view.bounds.width - 80) / 2
        let top = (self.view.bounds.height / 4 - 80) / 2 + 20
        avatar = UIImageView.init(frame: CGRect.init(x: left, y: top, width: 80, height: 80))
        // TODO avatar Image可以设置缓存，本地存储
        avatar.image = UIImage.init(named: "login_avatar_default.png")
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
        // TODO 用户名保存到全局变量
        username.text = ""
        
        let border = UIView.init(frame: CGRect.init(x: 20, y: top + 60, width: width, height: 1))
        border.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1)
        self.view.addSubview(border)
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
        // TODO 密码保存到全局变量
        password.text = ""
        
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
        // TODO 开关更具上次的选择设置
        remember_password.setOn(true, animated: true)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // 登录事件
    @IBAction func login_pressed(_ sender: UIButton) {
        print("IBAction Actived.");
        // TODO 登录，登录成功进入TabBarController页面
        if username.text == "channing" && password.text == "p@ssw0rd" {
            self.performSegue(withIdentifier: "login_segue", sender: nil)
        }
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
