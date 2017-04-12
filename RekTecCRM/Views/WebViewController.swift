//
//  WebViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/12.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController{
    
    private var webview: UIWebView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        
        let fileManager = FileManager.default
        let wwwPath = FileUtils.cachesFolder() + "/www"
        if !fileManager.fileExists(atPath: wwwPath){
            try! fileManager.createDirectory(atPath: wwwPath, withIntermediateDirectories: true, attributes: nil)
        }
//        let srcUrl = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/_index.html"
        let toUrl = wwwPath + "/_index.html"
//        try! fileManager.copyItem(atPath: srcUrl, toPath: toUrl)
        
//        webview.performSelector(onMainThread: {() -> Void in }, with: nil, waitUntilDone: true)
        
        let url = toUrl + "#/app/login"
        webview.loadRequest(URLRequest.init(url: URL.init(string: url)!))
        
//        let a = "window.location.href='index.html';"
//        webview.stringByEvaluatingJavaScript(from: a)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
