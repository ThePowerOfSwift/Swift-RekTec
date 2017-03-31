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
        if avatar == nil || avatar!.isEmpty{
            return UIImage.init(named: "login_avatar_default.png")
        }
        return ImageUtils.base64StringToUIImage(base64String: avatar!)
    }
    
    // 从服务器获取用户的头像并存入到本地缓存
    class func getUserAvatarFromCloud(systemUserId: String){
        let url = "http://192.168.1.232:7777/api/AvatarFile/GetBase64FileContentByObjectId?moduleType=SystemUser&objectid=\(systemUserId)";
        AlamofireHeaders.updateHeadersAuth()
        Alamofire.request(url, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                FileUtils.saveBase64StringToCache(id: systemUserId, content: value as! String)
            case .failure(let error):
                print(error)
            }
        })
    }
}
