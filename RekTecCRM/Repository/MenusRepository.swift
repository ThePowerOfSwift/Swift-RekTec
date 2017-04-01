//
//  MenusRepository.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/1.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation

class MenusRepository{
    public static let PARENTMENUSTABLE: String = "ParentMenusTable"
    public static let CHILDMENUSTABLE: String = "ChildMenusTable"
    
    static var fontIcon = ColumnType(colName: "FontIcon", colType: "VARCHAR(8000)", colValue: nil)
    static var menuIcon = ColumnType(colName: "MenuIcon", colType: "VARCHAR(8000)", colValue: nil)
    static var menuType = ColumnType(colName: "MenuType", colType: "VARCHAR(100)", colValue: nil)
    static var isActive = ColumnType(colName: "IsActive", colType: "INT", colValue: nil)
    static var systemMenuId = ColumnType(colName: "SystemMenuId", colType: "VARCHAR(100)", colValue: nil)
    static var parentMenuCode = ColumnType(colName: "ParentMenuCode", colType: "VARCHAR(100)", colValue: nil)
    static var parentMenuId = ColumnType(colName: "ParentMenuId", colType: "VARCHAR(100)", colValue: nil)
    static var menuSeq = ColumnType(colName: "MenuSeq", colType: "INT", colValue: nil)
    static var menuCode = ColumnType(colName: "MenuCode", colType: "VARCHAR(100)", colValue: nil)
    static var menuName = ColumnType(colName: "MenuName", colType: "VARCHAR(100)", colValue: nil)
    
    // 创建父菜单缓存表
    class func createParentMenusTable(){
        var menusTable = [ColumnType]()
        menusTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName]
        SQliteRepository.createTable(tableName: PARENTMENUSTABLE, columns: menusTable)
    }
    
    // 创建子菜单缓存表
    class func createChildMenusTable(){
        var menusTable = [ColumnType]()
        menusTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName]
        SQliteRepository.createTable(tableName: CHILDMENUSTABLE, columns: menusTable)
    }
    
    // 插入或更新菜单缓存
    class func insertOrUpdateTable(parentMenus: [SystemMenus], childMenus: [SystemMenus]){
        var parentMenuTable = [ColumnType](), childMenuTable = [ColumnType]()
        var parentMenusTable = [[ColumnType]](), childMenusTable = [[ColumnType]]()
        for pmenu in parentMenus {
            fontIcon.colValue = pmenu.FontIcon
            menuIcon.colValue = pmenu.MenuIcon
            menuType.colValue = pmenu.MenuType
            isActive.colValue = pmenu.IsActive
            systemMenuId.colValue = pmenu.SystemMenuId
            parentMenuCode.colValue = pmenu.ParentMenuCode
            parentMenuId.colValue = pmenu.ParentMenuId
            menuSeq.colValue = pmenu.MenuSeq
            menuCode.colValue = pmenu.MenuCode
            menuName.colValue = pmenu.MenuName
            parentMenuTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName]
            parentMenusTable += [parentMenuTable]
            parentMenuTable.removeAll()
        }
        _ = SQliteRepository.syncInsert(tableName: PARENTMENUSTABLE, rowValue: parentMenusTable)
        for cmenu in childMenus {
            fontIcon.colValue = cmenu.FontIcon
            menuIcon.colValue = cmenu.MenuIcon
            menuType.colValue = cmenu.MenuType
            isActive.colValue = cmenu.IsActive
            systemMenuId.colValue = cmenu.SystemMenuId
            parentMenuCode.colValue = cmenu.ParentMenuCode
            parentMenuId.colValue = cmenu.ParentMenuId
            menuSeq.colValue = cmenu.MenuSeq
            menuCode.colValue = cmenu.MenuCode
            menuName.colValue = cmenu.MenuName
            childMenuTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName]
            childMenusTable += [parentMenuTable]
            childMenuTable.removeAll()
        }
        _ = SQliteRepository.syncInsert(tableName: CHILDMENUSTABLE, rowValue: childMenusTable)
        
        // TODO 通知可以解锁进程阻塞
    }
}
