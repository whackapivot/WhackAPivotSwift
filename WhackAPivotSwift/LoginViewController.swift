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
    
    @IBOutlet weak var webView: UIWebView!
    
    var urlProvider: URLProvider!
    var peopleService: PeopleService!
    
    let authToken = "authToken"
    let loginPath = "/mobile_login"
    let successPath = "/mobile_success"
    
    var seguePerformed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: urlProvider.urlForPath(loginPath)))
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
            
            if let pivotsTwoSessionValue = pivotsTwoSession?.value {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(pivotsTwoSessionValue, forKey: authToken)
                defaults.synchronize()
                peopleService.assemblePeople {
                    self.performSegueWithIdentifier()
                }
            }
        }
    }
    
    private func performSegueWithIdentifier() {
        seguePerformed = true   // only for unit testing purposes
        self.performSegueWithIdentifier("MainView", sender: self)
    }
}
