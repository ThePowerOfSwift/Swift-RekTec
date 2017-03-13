//
//  BaseStoryBoardSegue.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/13.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class BaseStoryboardSegue: UIStoryboardSegue {
    
    // 控制登录页面到TabBarController页面的过渡动画
    override func perform() {
        let sourceView = self.source.view
        let destView = self.destination.view
        
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.insertSubview(destView!, aboveSubview: sourceView!)
        
        destView?.alpha = 0.0
        
        UIView.animate(withDuration: 0.3, animations: {
            destView?.alpha = 1.0
        })
    }
}
