//
//  AuthenUser.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/20.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit

class AuthenUser{
    var uid: String
    var pwd: String
    let pluginKey: String = "LoginLog"
    var pluginContent: String
    
    init() {
        let LoginLogId = UUID().uuidString.lowercased()
        let OsVersion = UIDevice.current.systemVersion
        let Html5Version = GlobalAppSetting.wwwVersion
        let ClientType = "2"
        self.pluginContent = "{\"LoginLogId\":\"" + LoginLogId + "\",\"OsVersion\":\""
        self.pluginContent += OsVersion + "\",\"AppVersion\":" + "\"1.0.0.0\"" + ",\"Html5Version\":\""
        self.pluginContent += Html5Version + "\",\"ClientType\":" + ClientType + "}"
        self.uid = ""
        self.pwd = ""
    }
    
    var Uid: String{
        get{
            return self.uid
        }
        set{
            self.uid = newValue
        }
    }
    
    var Pwd: String{
        get{
            return self.pwd
        }
        set{
            self.pwd = newValue
        }
    }
}
