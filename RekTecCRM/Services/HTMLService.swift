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
    // HTML包下载
    class func upgradeHTML(){
        let url = GlobalAppSetting.xrmWebApiBaseUrl + "api/Update/GetUpdateInfo?clientType=3&versionCode=\(GlobalAppSetting.wwwVersion)"
        AlamofireHeaders.updateHeadersAuth()
        // 检查版本是否需要更新
        Alamofire.request(url, encoding: JSONEncoding.default, headers: AlamofireHeaders.headers).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success(let value):
                // 同步锁
                DispatchQueue(label: "Async2").sync() {
                    let json = JSON(value)
                    print(json)
                    if json == JSON.null || !json["IsUpdate"].boolValue{
                        return
                    }
                    // 下载HTML的压缩包
                    let downloadUrl = GlobalAppSetting.xrmWebApiBaseUrl + "FileDownloadHandler.ashx?moduletype=version&fileid=\(json["FileId"])"
                    
                    // NSURLRequest+NSURLConnection
                    let htmlUrl: NSURL = NSURL(string: downloadUrl)!
                    let request: NSURLRequest = NSURLRequest(url: htmlUrl as URL)
                    NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main, completionHandler:{
                        (response, data, error) -> Void in
                        if error != nil {
                            print(error!)
                        }
                        else {
                            // 把Data写成zip文件到./Document/www.zip
                            let manager = FileManager.default
                            let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
                            let zipUrl = urlForDocument[0]
                            let srcUrl = zipUrl.appendingPathComponent("www.zip")
                            manager.createFile(atPath: srcUrl.path, contents: data, attributes: nil)
                            // 新建解压目录
                            let wwwPath = FileUtils.cachesFolder() + "/www"
                            try! manager.createDirectory(atPath: wwwPath, withIntermediateDirectories: true, attributes: nil)
                            // 解压zip文件到./Documents/Library/Caches目录
                            SSZipArchive.unzipFile(atPath: srcUrl.path, toDestination: wwwPath, progressHandler: {_, _, _, _ in
                            }, completionHandler: {(path, isSuccess, error) in
                                // 删除本地的zip文件
                                try! manager.removeItem(at: srcUrl)
                                // 更新本地www版本号
                                GlobalAppSetting.wwwVersion = json["VersionCode"].stringValue
                                // 查看存放HTML目录中的文件
                                // let contentsOfPath = try? manager.contentsOfDirectory(atPath: wwwPath)
                                // print("contentsOfPath: \(contentsOfPath)")
                            })
                        }
                    })
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}





















