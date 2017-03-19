//
//  UserServices.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/19.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit

class UserServices{
    
    // 获取用户头像，缓存中有则直接从缓存取，若缓存中无则使用默认头像
    class func getUserAvatarFromCacheOrDefault(systemUserId: String) -> UIImage?{
        let avatar = FileUtils.getBase64StringFromCache(id: systemUserId)
        if avatar == nil || avatar!.isEmpty{
            return UIImage.init(named: "login_avatar_default.png")
        }
        return ImageUtils.base64StringToUIImage(base64String: avatar!)
    }
}
