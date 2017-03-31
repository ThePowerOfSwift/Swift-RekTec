//
//  AlamofireHeaders.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/30.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireHeaders{
    
    public static var headers: HTTPHeaders = [
        "Authorization": "Basic " + GlobalAppSetting.xrmAuthToken,
        "Content-Type": "application/json",
        "Accept": "",
        "Accept-Language": "",
        "Accept-Encoding": ""
    ]
    
    class func updateHeadersAuth(){
        self.headers["Authorization"] = "Basic " + GlobalAppSetting.xrmAuthToken
    }
}
