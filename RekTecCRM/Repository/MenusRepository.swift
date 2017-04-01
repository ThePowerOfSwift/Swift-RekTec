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
    
    static let fontIcon = ColumnType(colName: "FontIcon", colType: "VARCHAR(MAX)", colValue: nil)
    static let menuIcon = ColumnType(colName: "MenuIcon", colType: "VARCHAR(MAX)", colValue: nil)
    static let menuType = ColumnType(colName: "MenuType", colType: "VARCHAR(100)", colValue: nil)
    static let isActive = ColumnType(colName: "IsActive", colType: "INT", colValue: nil)
    static let systemMenuId = ColumnType(colName: "SystemMenuId", colType: "VARCHAR(100)", colValue: nil)
    static let parentMenuCode = ColumnType(colName: "ParentMenuCode", colType: "VARCHAR(100)", colValue: nil)
    static let parentMenuId = ColumnType(colName: "ParentMenuId", colType: "VARCHAR(100)", colValue: nil)
    static let menuSeq = ColumnType(colName: "MenuSeq", colType: "INT", colValue: nil)
    static let menuCode = ColumnType(colName: "MenuCode", colType: "VARCHAR(100)", colValue: nil)
    static let menuName = ColumnType(colName: "MenuName", colType: "VARCHAR(100)", colValue: nil)
    
    class func createParentMenusTable(){
        var menusTable = [ColumnType]()
        menusTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName]
        SQliteRepository.createTable(tableName: PARENTMENUSTABLE, columns: menusTable)
    }
    
    class func createChildMenusTable(){
        var menusTable = [ColumnType]()
        menusTable += [fontIcon, menuIcon, menuType, isActive, systemMenuId, parentMenuCode, parentMenuId, menuSeq, menuCode, menuName]
        SQliteRepository.createTable(tableName: CHILDMENUSTABLE, columns: menusTable)
    }
}
