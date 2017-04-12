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
    private let metroMenuPadding: CGFloat = 20
    private let metroMenuIconWidth: CGFloat = 42
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去除ScrollView上部分的空白区域
        self.automaticallyAdjustsScrollViewInsets = false
        
        let systemMenus = MenusRepository.getSystemMenusFromDb()
        
        banaImage.frame = CGRect.init(x: 0, y: 65, width: self.view.bounds.width, height: 136)
        
        let borderLine = UILabel.init(frame: CGRect.init(x: 0, y: 200, width: self.view.bounds.width, height: 1))
        borderLine.backgroundColor = UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
        self.view.addSubview(borderLine)
        
        menusRender(top: 201, menus: systemMenus)
    }
    
    // 菜单绘制
    func menusRender(top: CGFloat, menus: [[String: Any]]){
        scrollView.frame = CGRect.init(x: 0, y: top, width: self.view.bounds.width, height: self.view.bounds.height - 49)
        
        let stringSize: CGFloat = 16
        let menuButtonHeight: CGFloat = metroMenuPadding * 2 + metroMenuIconWidth + 10
        let menuButtonWidth = self.view.bounds.width / metroMenuColCount
        var col: CGFloat = 0
        var row: CGFloat = 0
        
        for menu in menus {
            let button = UIButton.init(type: .custom)
            button.frame = CGRect.init(x: col * menuButtonWidth, y: row * menuButtonHeight, width: menuButtonWidth, height: menuButtonHeight)
            button.backgroundColor = .clear
            button.clearsContextBeforeDrawing = false
            button.autoresizingMask = UIViewAutoresizing(rawValue: UInt(1 << 3))
            button.setBackgroundImage(ImageUtils.imageWithColor(color: UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1), rect: CGRect.init(x: 0, y: 0, width: menuButtonWidth, height: menuButtonHeight)), for: .highlighted)
            button.setBackgroundImage(ImageUtils.imageWithColor(color: UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1), rect: CGRect.init(x: 0, y: 0, width: menuButtonWidth, height: menuButtonHeight)), for: .focused)
            button.setBackgroundImage(ImageUtils.imageWithColor(color: UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1), rect: CGRect.init(x: 0, y: 0, width: menuButtonWidth, height: menuButtonHeight)), for: .selected)
            button.setTitleColor(UIColor.init(red: 0, green: 0.478431, blue: 1, alpha: 1), for: .normal)
            
            let borderRight = UIView.init(frame: CGRect.init(x: menuButtonWidth - 1, y: 0, width: 1, height: menuButtonHeight))
            borderRight.backgroundColor = UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
            let borderLeft = UIView.init(frame: CGRect.init(x: 0, y: menuButtonHeight - 1, width: menuButtonWidth, height: 1))
            borderLeft.backgroundColor = UIColor.init(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
            button.addSubview(borderRight)
            button.addSubview(borderLeft)
            
            let iconImage = ImageUtils.base64StringToUIImage(base64String: menu["MenuIcon"] as! String)
            if iconImage != nil {
                let iconView = UIImageView.init(frame: CGRect.init(x: (menuButtonWidth - metroMenuIconWidth) / 2, y: metroMenuPadding - 4, width: metroMenuIconWidth, height: metroMenuIconWidth))
                iconView.image = iconImage
                button.addSubview(iconView)
            }
            
            let buttonLabel = UILabel.init(frame: CGRect.init(x: 0, y: metroMenuPadding + metroMenuIconWidth + 6, width: menuButtonWidth, height: stringSize))
            buttonLabel.text = menu["MenuName"] as? String
            buttonLabel.textColor = UIColor.init(red: 85 / 255, green: 85 / 255, blue: 85 / 255, alpha: 1)
            buttonLabel.textAlignment = .center
            buttonLabel.font = UIFont.systemFont(ofSize: 14)
            button.addSubview(buttonLabel)
            
            // TODO 绑定菜单的点击事件
            
            scrollView.addSubview(button)
            
            col += 1
            if col == metroMenuColCount {
                col = 0
                row += 1
            }
        }
        scrollView.contentSize = CGSize.init(width: 0, height: row * menuButtonHeight)
    }
    
    func menuTouchUpInside(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}












