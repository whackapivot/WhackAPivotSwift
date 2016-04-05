//
//  LoginViewController.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 4/4/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import UIKit
import WebKit

protocol LoginViewControllerDelegate {
    func loginSuccessful()
}


class LoginViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var delegate: LoginViewControllerDelegate!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
