//
//  UserServices.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/19.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class UserService{
    
    // 获取用户头像，缓存中有则直接从缓存取，若缓存中无则使用默认头像
    class func getUserAvatarFromCacheOrDefault(systemUserId: String) -> UIImage?{
        let avatar = FileUtils.getBase64StringFromCache(id: systemUserId)
        if avatar != nil && !avatar!.isEmpty{
            return ImageUtils.base64StringToUIImage(base64String: avatar!)
        }
        
        let url = "http://192.168.1.232:7777/api/AvatarFile/GetBase64FileContentByObjectId";
        //?moduleType=SystemUser&objectid={0}
        let parameters: Parameters = [
            "moduleType": "SystemUser",
            "objectid": systemUserId,
        ]
        var returnAvatar: UIImage?
        Alamofire.request(url, parameters: parameters, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                print(value)
                returnAvatar = nil
            case .failure(let error):
                print(error)
                returnAvatar = nil
            }
        })
        
        if returnAvatar == nil{
            return UIImage.init(named: "login_avatar_default.png")
        }
        return returnAvatar
    }
}
