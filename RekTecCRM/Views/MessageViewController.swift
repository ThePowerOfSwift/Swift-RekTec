//
//  FirstViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var debugModel: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        debugModel.isOn = GlobalAppSetting.isHTML5Debug
        
        print("This is First View")
    }

    @IBAction func debugModelChange(_ sender: UISwitch) {
        GlobalAppSetting.isHTML5Debug = !GlobalAppSetting.isHTML5Debug
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

