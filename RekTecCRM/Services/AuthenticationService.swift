//
//  AuthenticationService.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/20.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class AuthenticationService {
    
    // 用户登录接口
    class func loginCheck(authenUser: AuthenUser, success: @escaping(JSON) -> Void, failure: @escaping(Any) -> Void){
        let url = "http://192.168.1.232:7777/api/Authentication/login"
        let parameters: Parameters = [
            "uid": authenUser.Uid,
            "pwd": authenUser.Pwd,
            "pluginKey": authenUser.pluginKey,
            "pluginContent": authenUser.pluginContent
        ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                success(JSON(value))
            case .failure(let error):
                print(error.localizedDescription)
                failure(error.localizedDescription)
            }
        })
    }
}
//if let error = error as? AFError {
//    switch error {
//    case .invalidURL(let url):
//        print("无效 URL: \(url) - \(error.localizedDescription)")
//    case .parameterEncodingFailed(let reason):
//        print("参数编码失败: \(error.localizedDescription)")
//        print("失败理由: \(reason)")
//    case .multipartEncodingFailed(let reason):
//        print("Multipart encoding 失败: \(error.localizedDescription)")
//        print("失败理由: \(reason)")
//    case .responseValidationFailed(let reason):
//        print("Response 校验失败: \(error.localizedDescription)")
//        print("失败理由: \(reason)")
//        
//        switch reason {
//        case .dataFileNil, .dataFileReadFailed:
//            print("无法读取下载文件")
//        case .missingContentType(let acceptableContentTypes):
//            print("文件类型不明: \(acceptableContentTypes)")
//        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
//            print("文件类型: \(responseContentType) 无法读取: \(acceptableContentTypes)")
//        case .unacceptableStatusCode(let code):
//            print("请求返回状态码出错: \(code)")
//        }
//    case .responseSerializationFailed(let reason):
//        print("请求返回内容序列化失败: \(error.localizedDescription)")
//        print("失败理由: \(reason)")
//    }
//}
