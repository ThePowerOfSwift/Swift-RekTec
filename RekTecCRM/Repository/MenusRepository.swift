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
    static var menuUrl = ColumnType(colName: "MenuUrl", colType: "VARCHAR(100)", colValue: nil)
    
    // 创建父菜单缓存表
    class func createParentMenusTable(){
        var menusTable = [ColumnType]()
        menusTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName, menuUrl]
        SQliteRepository.createTable(tableName: PARENTMENUSTABLE, columns: menusTable)
    }
    
    // 创建子菜单缓存表
    class func createChildMenusTable(){
        var menusTable = [ColumnType]()
        menusTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName, menuUrl]
        SQliteRepository.createTable(tableName: CHILDMENUSTABLE, columns: menusTable)
    }
    
    // 插入或更新菜单缓存
    class func insertOrUpdateTable(parentMenus: [SystemMenus], childMenus: [SystemMenus]){
        var _fontIcon = ColumnType(colName: "FontIcon", colType: nil, colValue: nil)
        var _menuIcon = ColumnType(colName: "MenuIcon", colType: nil, colValue: nil)
        var _menuType = ColumnType(colName: "MenuType", colType: nil, colValue: nil)
        var _isActive = ColumnType(colName: "IsActive", colType: nil, colValue: nil)
        var _systemMenuId = ColumnType(colName: "SystemMenuId", colType: nil, colValue: nil)
        var _parentMenuCode = ColumnType(colName: "ParentMenuCode", colType: nil, colValue: nil)
        var _parentMenuId = ColumnType(colName: "ParentMenuId", colType: nil, colValue: nil)
        var _menuSeq = ColumnType(colName: "MenuSeq", colType: nil, colValue: nil)
        var _menuCode = ColumnType(colName: "MenuCode", colType: nil, colValue: nil)
        var _menuName = ColumnType(colName: "MenuName", colType: nil, colValue: nil)
        var _menuUrl = ColumnType(colName: "MenuUrl", colType: nil, colValue: nil)
        
        var parentMenuTable = [ColumnType](), childMenuTable = [ColumnType]()
        var parentMenusTable = [[ColumnType]](), childMenusTable = [[ColumnType]]()
        for pmenu in parentMenus {
            _fontIcon.colValue = pmenu.FontIcon
            _menuIcon.colValue = pmenu.MenuIcon
            _menuType.colValue = pmenu.MenuType
            _isActive.colValue = pmenu.IsActive
            _systemMenuId.colValue = pmenu.SystemMenuId
            _parentMenuCode.colValue = pmenu.ParentMenuCode
            _parentMenuId.colValue = pmenu.ParentMenuId
            _menuSeq.colValue = pmenu.MenuSeq
            _menuCode.colValue = pmenu.MenuCode
            _menuName.colValue = pmenu.MenuName
            _menuUrl.colValue = pmenu.MenuUrl
            parentMenuTable += [_fontIcon, _menuIcon, _menuType, _isActive, _systemMenuId, _parentMenuCode, _parentMenuId, _menuSeq, _menuCode, _menuName]
            parentMenusTable += [parentMenuTable]
            parentMenuTable.removeAll()
        }
        _ = SQliteRepository.syncInsert(tableName: PARENTMENUSTABLE, rowValue: parentMenusTable)
        for cmenu in childMenus {
            _fontIcon.colValue = cmenu.FontIcon
            _menuIcon.colValue = cmenu.MenuIcon
            _menuType.colValue = cmenu.MenuType
            _isActive.colValue = cmenu.IsActive
            _systemMenuId.colValue = cmenu.SystemMenuId
            _parentMenuCode.colValue = cmenu.ParentMenuCode
            _parentMenuId.colValue = cmenu.ParentMenuId
            _menuSeq.colValue = cmenu.MenuSeq
            _menuCode.colValue = cmenu.MenuCode
            _menuName.colValue = cmenu.MenuName
            _menuUrl.colValue = cmenu.MenuUrl
            childMenuTable += [_fontIcon, _menuIcon, _menuType, _isActive, _systemMenuId, _parentMenuCode, _parentMenuId, _menuSeq, _menuCode, _menuName]
            childMenusTable += [parentMenuTable]
            childMenuTable.removeAll()
        }
        _ = SQliteRepository.syncInsert(tableName: CHILDMENUSTABLE, rowValue: childMenusTable)
        
        // TODO 通知可以解锁进程阻塞
    }
    
    // 从本地数据库获取菜单用于显示在界面上
    class func getSystemMenusFromDb() -> [[String: Any]] {
        return SQliteRepository.getData(tableName: CHILDMENUSTABLE)
    }
    
    class func getSystemMenusFromDb1() -> [[String: Any]] {
        return SQliteRepository.getData(tableName: PARENTMENUSTABLE)
    }
}
