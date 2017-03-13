//
//  LoginViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var login_avatar: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var remember_password: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I'm in.")
        let left = (self.view.bounds.width - 80) / 2 + 10
        let top = (self.view.bounds.height / 4 - 80) / 2 + 20
        login_avatar.frame = CGRect.init(x: left, y: top, width: 80, height: 80)
        login_avatar.image = UIImage.init(named: "login_avatar_default.png")
    }
    
    func setLoginAvatar(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // 服务器地址设置
    @IBAction func server_address_pressed(_ sender: UIButton) {
        print("设置服务器地址")
    }
    
    // 登录事件
    @IBAction func login_pressed(_ sender: UIButton) {
        print("IBAction Actived.");
        // TODO 登录，登录成功进入TabBarController页面
        self.performSegue(withIdentifier: "login_segue", sender: nil)
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
