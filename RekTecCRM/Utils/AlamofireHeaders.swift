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
    
    // H5包下载完成标记
    public static var h5downloaded: Bool = false
    
    class func setH5Downloaded(value: Bool){
        self.h5downloaded = value
    }
    
    class func updateHeadersAuth(){
        self.headers["Authorization"] = "Basic " + GlobalAppSetting.xrmAuthToken
    }
}
