//
//  SystemMenus.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/1.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation

// 系统菜单Model
class SystemMenus{
    private var fontIcon: String, menuIcon: String, menuType: String, systemMenuId: String, parentMenuCode: String
    private var parentMenuId: String, menuCode: String, menuName: String
    private var isActive: Int, menuSeq: Int
    
    init(){
        self.fontIcon = ""
        self.menuIcon = ""
        self.menuType = ""
        self.systemMenuId = ""
        self.parentMenuCode = ""
        self.parentMenuId = ""
        self.menuCode = ""
        self.menuName = ""
        self.isActive = -1
        self.menuSeq = -1
    }
    
    var FontIcon: String{
        get{
            return self.fontIcon
        }
        set{
            self.fontIcon = newValue
        }
    }
    
    var MenuIcon: String{
        get{
            return self.menuIcon
        }
        set{
            self.menuIcon = newValue
        }
    }
    
    var MenuType: String{
        get{
            return self.menuType
        }
        set{
            self.menuType = newValue
        }
    }
    
    var SystemMenuId: String{
        get{
            return self.systemMenuId
        }
        set{
            self.systemMenuId = newValue
        }
    }
    
    var ParentMenuCode: String{
        get{
            return self.parentMenuCode
        }
        set{
            self.parentMenuCode = newValue
        }
    }
    
    var ParentMenuId: String{
        get{
            return self.parentMenuId
        }
        set{
            self.parentMenuId = newValue
        }
    }
    
    var MenuCode: String{
        get{
            return self.menuCode
        }
        set{
            self.menuCode = newValue
        }
    }
    
    var MenuName: String{
        get{
            return self.menuName
        }
        set{
            self.menuName = newValue
        }
    }
    
    var IsActive: Int{
        get{
            return self.isActive
        }
        set{
            self.isActive = newValue
        }
    }
    
    var MenuSeq: Int{
        get{
            return self.menuSeq
        }
        set{
            self.menuSeq = newValue
        }
    }
}
