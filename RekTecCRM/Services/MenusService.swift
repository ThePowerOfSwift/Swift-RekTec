//
//  MenusService.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/1.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MenusService{
    // 从服务器获取系统菜单，并把菜单缓存到本地数据库中
    class func getSystemMenusFromCloud(lastUpdateTime: String){
        let url = GlobalAppSetting.xrmWebApiBaseUrl + "api/SystemMenu/GetMobileSystemMenu?lastQueryTime=\(lastUpdateTime)"
        
        AlamofireHeaders.updateHeadersAuth()
        // 从服务器获取系统菜单
        Alamofire.request(url, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers)
            .responseJSON(completionHandler: {
                response in
                switch response.result {
                case .success(let value):
                    let systemMenuList = JSON(value)
                    // print(systemMenuList)
                    GlobalAppSetting.lastSyncTimeForMenus = systemMenuList["SystemMenuSyncTime"].stringValue
                    GlobalAppSetting.systemMenuStyle = systemMenuList["SystemMenuStyle"].stringValue
                    
                    // 把菜单缓存到本地数据库中
                    let menuList = systemMenuList["SystemMenuList"]
                    if systemMenuList["SystemMenuList"] != JSON.null || menuList.count > 0 {
                        var parentSystemMenus = [SystemMenus]()    // 待保存的父菜单
                        var childSystemMenus = [SystemMenus]()     // 待保存的子菜单
                        for menus in menuList.arrayValue {
                            let pmenu = SystemMenus()
                            pmenu.FontIcon = menus["FontIcon"].stringValue
                            pmenu.IsActive = menus["IsActive"].int!
                            pmenu.MenuCode = menus["MenuCode"].stringValue
                            pmenu.MenuIcon = menus["MenuIcon"].stringValue
                            pmenu.MenuName = menus["MenuName"].stringValue
                            pmenu.MenuSeq = menus["MenuSeq"].int!
                            pmenu.MenuType = menus["MenuType"].stringValue
                            pmenu.ParentMenuCode = menus["ParentMenuCode"].stringValue
                            pmenu.ParentMenuId = menus["ParentMenuId"].stringValue
                            pmenu.SystemMenuId = menus["SystemMenuId"].stringValue
                            pmenu.MenuUrl = menus["MenuUrl"].stringValue
                            parentSystemMenus += [pmenu]
                            
                            if menus["Children"] == JSON.null || menus["Children"].count <= 0 {
                                continue
                            }
                            
                            for childMenus in menus["Children"].arrayValue {
                                let cmenu = SystemMenus()
                                cmenu.FontIcon = childMenus["FontIcon"].stringValue
                                cmenu.IsActive = childMenus["IsActive"].int!
                                cmenu.MenuCode = childMenus["MenuCode"].stringValue
                                cmenu.MenuIcon = childMenus["MenuIcon"].stringValue
                                cmenu.MenuName = childMenus["MenuName"].stringValue
                                cmenu.MenuSeq = childMenus["MenuSeq"].int!
                                cmenu.MenuType = childMenus["MenuType"].stringValue
                                cmenu.ParentMenuCode = childMenus["ParentMenuCode"].stringValue
                                cmenu.ParentMenuId = childMenus["ParentMenuId"].stringValue
                                cmenu.SystemMenuId = childMenus["SystemMenuId"].stringValue
                                cmenu.MenuUrl = childMenus["MenuUrl"].stringValue
                                childSystemMenus += [cmenu]
                            }
                        }
                        // 存数据库
                        MenusRepository.insertOrUpdateTable(parentMenus: parentSystemMenus, childMenus: childSystemMenus)
                    }
                case .failure(let error):
                    print(error)
                }
            })
    }
}
