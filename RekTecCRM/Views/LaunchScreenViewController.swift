//
//  LaunchScreenViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/15.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController{
    
    @IBOutlet weak var launchScreenImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("log")
        launchScreenImage.frame = self.view.frame
        launchScreenImage.image = UIImage.init(named: "default.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
