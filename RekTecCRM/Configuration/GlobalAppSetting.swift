//
//  File.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/17.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation

class GlobalAppSetting{
    // 是否是第一次打开应用
    static var isFirstOpen: Bool{
        get{
            let v = UserDefaults.standard.value(forKey: "isFirstOpen")
            return v == nil ? false : v as! Bool
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isFirstOpen")
            UserDefaults.standard.synchronize()
        }
    }
    
    // App的版本号，通过这个来控制本地数据库的版本，此版本号发生变化，则会导致创建一个新的数据库文件
    static var localDBVersion: String{
        return "170318"
    }

    // 用户上次登录的账号
    static var userName: String{
        get{
            let v = UserDefaults.standard.value(forKey: "userName")
            return v == nil ? "" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "userName")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 用户上次登录的密码
    static var password: String{
        get{
            let v = UserDefaults.standard.value(forKey: "password")
            return v == nil ? "" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "password")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 用于访问XRM的WebApi的身份验证的Token
    static var xrmAuthToken: String{
        get{
            let v = UserDefaults.standard.value(forKey: "xrmAuthToken")
            return v == nil ? "" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "xrmAuthToken")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 用于访问XRM的WebApi的基础URL地址
    static var xrmWebApiBaseUrl: String{
        get{
            let v = UserDefaults.standard.value(forKey: "xrmWebApiBaseUrl")
            return v == nil ? "" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "xrmWebApiBaseUrl")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 当前用户的SystemUserId
    static var systemUserId: String{
        get{
            let v = UserDefaults.standard.value(forKey: "systemUserId")
            return v == nil ? "" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "systemUserId")
            UserDefaults.standard.synchronize()
        }
    }
    
    // HTML5版本号
    static var wwwVersion: String{
        get{
            let v = UserDefaults.standard.value(forKey: "wwwVersion")
            return v == nil ? "1.0.0.0" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "wwwVersion")
            UserDefaults.standard.synchronize()
        }
    }
    
    // HTML5版本号
    static var isHTML5Debug: Bool{
        get{
            let v = UserDefaults.standard.value(forKey: "isHTML5Debug")
            return v == nil ? false : v as! Bool
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isHTML5Debug")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 是否记住密码
    static var isRememberPassword: Bool{
        get{
            let v = UserDefaults.standard.value(forKey: "isRememberPassword")
            return v == nil ? false : v as! Bool
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "isRememberPassword")
            UserDefaults.standard.synchronize()
        }
    }
    
    // 菜单的同步时间
    static var lastSyncTimeForMenus: String{
        get{
            let v = UserDefaults.standard.value(forKey: "lastSyncTimeForMenus")
            return v == nil ? "" : v as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "lastSyncTimeForMenus")
            UserDefaults.standard.synchronize()
        }
    }
}
