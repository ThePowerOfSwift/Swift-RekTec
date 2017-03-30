//
//  AuthenticationService.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/20.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthenticationService {
    
    // 用户登录接口
    class func loginCheck(authenUser: AuthenUser, success: @escaping(JSON) -> Void, failure: @escaping(JSON) -> Void){
        let url = "http://192.168.1.232:7777/api/Authentication/login"
        let parameters: Parameters = [
            "uid": authenUser.uid,
            "pwd": authenUser.pwd,
            "pluginKey": authenUser.pluginKey,
            "pluginContent": authenUser.pluginContent
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                success(JSON(value))
            case .failure(let error):
                failure(JSON(error))
            }
        })
    }
}
