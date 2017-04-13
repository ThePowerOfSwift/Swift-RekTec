//
//  WebViewController.swift
//  RekTecCRM
//
//  Created by Channing on 2017/4/12.
//  Copyright © 2017年 Channing Kuo. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController, UIWebViewDelegate{
    
    private var webview: UIWebView!
    var menuUrl: String? = ""
    
    init(menuUrl: String) {
        self.menuUrl = menuUrl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        webview = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        
        webview.delegate = self
        
        let manager = FileManager.default
        let wwwPath = FileUtils.cachesFolder() + "/www/"
        let rp = Bundle.main.resourcePath
        let _indexPath = (rp! as NSString).appendingPathComponent("_blank.html")
//        let _indexPath1 = (rp! as NSString)
//        let contentsOfPath = try? manager.contentsOfDirectory(atPath: wwwPath)
//        print("contentsOfPath: \(contentsOfPath)")
        let toPath = wwwPath + "_blank.html"
        if !manager.fileExists(atPath: toPath) {
            try! manager.copyItem(atPath: _indexPath, toPath: toPath)
        }
        
        var url = wwwPath + "_blank.html"
        if GlobalAppSetting.isHTML5Debug {
            url = GlobalAppSetting.xrmWebApiBaseUrl + "debug/index.html"
        }
        webview.loadRequest(URLRequest.init(url: URL.init(string: url)!))
        
        self.view.addSubview(webview)
    }
    
    // URL变更时捕获方法，可用来HTML和Swift交互
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        // HTML Swift 交互
        let requesturl = request.url?.absoluteString
        
        //检测到URL里包含app/close,则关闭应用
        if (requesturl?.contains("/app/close"))! {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.navigationController?.popViewController(animated: true)
            
            webView.stopLoading()
//            webView.removeFromSuperview () //动画黑边
            
            return false;
        }
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView){
        print("开始加载...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        webview.stringByEvaluatingJavaScript(from: "window.localStorage.setItem('XrmDeviceGeoIOS','true');")
        webview.stringByEvaluatingJavaScript(from: "window.localStorage.setItem('XrmBaseUrl','\(GlobalAppSetting.xrmWebApiBaseUrl)');")
        webview.stringByEvaluatingJavaScript(from: "window.localStorage.setItem('XrmAuthToken','\(GlobalAppSetting.xrmAuthToken)');")
        webview.stringByEvaluatingJavaScript(from: "window.localStorage.setItem('UserId','\(GlobalAppSetting.systemUserId)');")
        webview.stringByEvaluatingJavaScript(from: "window.location.href='index.html#/\(String(describing: self.menuUrl!))?v=1';")
//        webview.stringByEvaluatingJavaScript(from: "window.location.href='index.html#/notice/noticeView?v=1';")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        print(error)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
