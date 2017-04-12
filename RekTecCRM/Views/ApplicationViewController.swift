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
    
    private let metroMenuColCount: CGFloat = 4
    private let metroMenuPadding = 25
    private let metroMenuIconWidth = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let systemMenus = MenusRepository.getSystemMenusFromDb()
        
        banaImage.frame = CGRect.init(x: 0, y: 65, width: self.view.bounds.width, height: 200)
        
        menusRender(top: banaImage.frame.height, menus: systemMenus)
    }
    
    func menusRender(top: CGFloat, menus: [[String: Any]]){
        scrollView.frame = CGRect.init(x: 0, y: top, width: self.view.bounds.width, height: self.view.bounds.height - 49)
//        scrollView.contentSize = CGSize.init(width: 0, height: row * 100)
        scrollView.backgroundColor = .gray
        
        var menuButtonHeight: CGFloat = 0.0
        let menuButtonWidth = self.view.bounds.width / metroMenuColCount
        var col: CGFloat = 0
        var row: CGFloat = 0
        
        for menu in menus {
            menuButtonHeight = CGFloat(metroMenuPadding * 2 + 10 + metroMenuIconWidth + 10)
            let button = UIButton.init(type: .custom)
            button.backgroundColor = .clear
            button.clearsContextBeforeDrawing = false
            button.autoresizingMask = UIViewAutoresizing(rawValue: UInt(1 << 3))
            button.setTitle(menu["MenuName"] as? String, for: .normal)
            button.setTitleColor(UIColor.init(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
            button.setBackgroundImage(ImageUtils.imageWithColor(color: UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1), rect: CGRect.init(x: 0, y: 0, width: menuButtonWidth, height: menuButtonHeight)), for: .highlighted)
            button.frame = CGRect.init(x: col * menuButtonWidth, y: row * menuButtonHeight, width: menuButtonWidth, height: menuButtonHeight)
            scrollView.addSubview(button)
            
            col += 1
            if col == metroMenuColCount {
                col = 0
                row += 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}












