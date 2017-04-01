//
//  SecondViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("应用Tab")
        let systemMenus1 = MenusRepository.getSystemMenusFromDb1()
        print(systemMenus1)
//        let systemMenus = MenusRepository.getSystemMenusFromDb()
//        print(systemMenus)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

