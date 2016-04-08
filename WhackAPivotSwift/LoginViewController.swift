import UIKit
import WebKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var urlProvider: URLProvider!
    var tokenStore: TokenStore!
    
    let authToken = "authToken"
    let loginPath = "/mobile_login"
    let successPath = "/mobile_success"
    
    var seguePerformed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if tokenStore.token != nil {
            performSegueWithIdentifier()
            return
        } else {
            webView.loadRequest(NSURLRequest(URL: urlProvider.urlForPath(loginPath)))
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if webView.request!.URL == urlProvider.urlForPath(successPath) {
            let cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            for cookie in cookieJar.cookies! {
                if cookie.name == "_pivots-two_session" {
                    tokenStore.token = cookie.value
                    self.performSegueWithIdentifier()
                }
            }
        }
    }
    
    private func performSegueWithIdentifier() {
        seguePerformed = true   // only for unit testing purposes
        self.performSegueWithIdentifier("PeopleViewController", sender: self)
    }
}
