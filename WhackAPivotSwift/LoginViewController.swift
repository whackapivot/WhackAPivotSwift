//
//  LoginViewController.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/4/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    
    var urlProvider: URLProvider!
    var webView: UIWebView!
    let authToken = "authToken"
    let loginPath = "/mobile_login"
    let successPath = "/mobile_success"
    
    override func loadView() {
        webView = UIWebView()
        webView.delegate = self
        view = webView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let url = NSURLRequest(URL: urlProvider.urlForPath(loginPath))
        webView.loadRequest(url)
    }

    
    func webViewDidFinishLoad(webView: UIWebView) {
        if webView.request!.URL == urlProvider.urlForPath(successPath) {
            let cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            
            var pivotsTwoSession: NSHTTPCookie?
            for cookie in cookieJar.cookies! {
                if cookie.name == "_pivots-two_session" {
                    pivotsTwoSession = cookie
                    break
                }
            }
            
            if pivotsTwoSession != nil {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(pivotsTwoSession!.value, forKey: authToken)
                defaults.synchronize()
                
                self.performSegueWithIdentifier("MainView", sender: self)
            }
        }
    }
}
