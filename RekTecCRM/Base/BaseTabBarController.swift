//
//  BaseTabBarController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseTabBarController: UITabBarController, NVActivityIndicatorViewable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 同步锁
        DispatchQueue(label: "").sync() {
            startAnimating(CGSize.init(width: 30, height: 30), type: .ballTrianglePath, color: .gray, backgroundColor: .clear)
            // TODO 更新资源H5
            HTMLService.upgradeHTML()
            // TODO 更新菜单
            print("Menus")
            self.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
