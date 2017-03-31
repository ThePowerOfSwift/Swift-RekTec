
//
//  MenusObserver.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/31.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import UIKit

class MyObserver: NSObject {
    
    var name:String = ""
    
    init(name:String){
        super.init()
        
        self.name = name
        let notificationName = Notification.Name(rawValue: "DownloadImageNotification")
        NotificationCenter.default.addObserver(self, selector:#selector(downloadImage(notification:)), name: notificationName, object: nil)
    }
    
    func downloadImage(notification: Notification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let value1 = userInfo["value1"] as! String
        let value2 = userInfo["value2"] as! Int
        
        print("\(name) 获取到通知，用户数据是［\(value1),\(value2)］")
        
        sleep(3)
        
        print("\(name) 执行完毕")
    }
    
    deinit {
        //记得移除通知监听
        NotificationCenter.default.removeObserver(self)
    }
}
