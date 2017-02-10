//
//  LoginViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationController?.pushViewController(BaseTabBarController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
