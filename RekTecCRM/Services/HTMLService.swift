//
//  MenusService.swift
//  RekTecCRM
//
//  Created by Channing on 2017/3/31.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HTMLService{
//    var apiUrl = "api/Update/GetUpdateInfo?clientType=4&versionCode={0}";
//    apiUrl = string.Format (apiUrl, GlobalAppSetting.WwwVersion);
//    var latestVersion = await RestClient.GetAsync<VersionUpdateModel> (apiUrl)
//				.ConfigureAwait (continueOnCapturedContext: false);
//    return latestVersion;
    
    class func upgradeHTML(){
        let url = "http://192.168.1.232:7777/api/Update/GetUpdateInfo?clientType=3&versionCode=\(GlobalAppSetting.wwwVersion)"
        AlamofireHeaders.updateHeadersAuth()
        // 检查版本是否需要更新
        Alamofire.request(url, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                if json == JSON.null || !json["IsUpdate"].boolValue{
                    return
                }
                // 下载HTML的压缩包
                let downloadUrl = "http://192.168.1.232:7777/FileDownloadHandler.ashx?moduletype=version&fileid=\(json["FileId"])"
                Alamofire.download(downloadUrl).responseData { response in
                    if let data = response.result.value {
                        print(data)
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
