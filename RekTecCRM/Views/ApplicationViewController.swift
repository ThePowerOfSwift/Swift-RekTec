//
//  SecondViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/2/10.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var banaImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let systemMenus = MenusRepository.getSystemMenusFromDb()
        
        banaImage.frame = CGRect.init(x: 0, y: 65, width: self.view.bounds.width, height: 200)
        
        menusRender(top: banaImage.frame.height, menus: systemMenus)
    }
    
    func menusRender(top: CGFloat, menus: [[String: Any]]){
        scrollView.frame = CGRect.init(x: 0, y: top, width: self.view.bounds.width, height: self.view.bounds.height - 49)
        let row = menus.count / 3 + 1
        scrollView.contentSize = CGSize.init(width: 0, height: row * 100)
        scrollView.backgroundColor = .gray
        // TODO 菜单布局
        for (index, item) in menus.enumerated() {
            let label = UILabel.init(frame: CGRect.init(x: 0, y: index * 20, width: Int(self.view.bounds.width), height: 100))
            label.text = item["MenuUrl"] as? String
            scrollView.addSubview(label)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

