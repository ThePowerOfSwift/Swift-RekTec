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
        // 同步锁
        DispatchQueue(label: "Async1").sync() {
//            startAnimating(CGSize.init(width: 30, height: 30), type: .ballTrianglePath, color: .gray, backgroundColor: .clear)
            // 更新资源H5
            HTMLService.upgradeHTML()
            // 更新菜单
            MenusService.getSystemMenusFromCloud(lastUpdateTime: GlobalAppSetting.lastSyncTimeForMenus)
//            self.stopAnimating()
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
