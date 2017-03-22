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
        let LoginLogId = UUID().uuidString
        let OsVersion = UIDevice.current.systemVersion
        var AppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String + "." + Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        let Html5Version = GlobalAppSetting.wwwVersion
        let ClientType = 2
        self.pluginContent = "{\"LoginLogId\":" + LoginLogId + ",\"OsVersion\":" + OsVersion + ",\"AppVersion\":" + AppVersion + ",\"Html5Version\":" + Html5Version + ",\"ClientType\":" + ClientType + "}"
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
