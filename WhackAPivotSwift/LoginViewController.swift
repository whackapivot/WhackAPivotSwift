import UIKit
import WebKit

class LoginViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var urlProvider: URLProvider?
    var tokenStore: TokenStore?
    var peopleStore: PeopleStore?
    
    let authToken = "authToken"
    let loginPath = "/mobile_login"
    let successPath = "/mobile_success"
    
    let peopleLoadingSegueId = "PeopleViewController"
    let gameSegueId = "segueToGame"
    
    var performSegueIdentifierArg: String?
    var performSegueSenderArg: AnyObject?
    var performSegueCallCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        if peopleStore?.people != nil {
            self.performSegueWithIdentifier(gameSegueId, sender: self)
            return
        }
        if tokenStore?.token != nil {
            performSegueWithIdentifier(peopleLoadingSegueId, sender: self)
            return
        } else {
            guard let url = urlProvider?.urlForPath(loginPath) else {return}
            webView.loadRequest(NSURLRequest(URL: url))
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if webView.request?.URL == urlProvider?.urlForPath(successPath) {
            let cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
            for cookie in cookieJar.cookies! {
                if cookie.name == "_pivots-two_session" {
                    tokenStore?.token = cookie.value
                    self.performSegueWithIdentifier(peopleLoadingSegueId, sender: self)
                }
            }
        }
    }
}
