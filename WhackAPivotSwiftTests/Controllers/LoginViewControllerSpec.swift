import Quick
import Nimble
import Swinject
import WebKit

@testable import WhackAPivotSwift

class LoginViewControllerSpec: SwinjectSpec {
    override func spec() {
        describe("LoginViewController") {
            var controller: LoginViewController!
            let testURLProvider = URLProviderImpl(baseURL: "http://cashcats.biz")
            
            class FakeTokenStore: TokenStore {
                var token: Token?
            }
            
            class FakeUIWebView: UIWebView {
                var loadRequestCallCount = 0
                var loadRequestURL: NSURLRequest!
                
                override func loadRequest(request: NSURLRequest) {
                    loadRequestCallCount += 1
                    loadRequestURL = request
                }
            }
            
            let fakeWebView: FakeUIWebView = FakeUIWebView()
            var fakeTokenStore: FakeTokenStore!
            
            beforeEach {
                fakeTokenStore = FakeTokenStore()
                
                self.testContainer.registerForStoryboard(LoginViewController.self) { _, controller in
                    controller.urlProvider = testURLProvider
                    controller.tokenStore = fakeTokenStore
                }
                
                
                controller = self.startController("LoginViewController", storyboardName: "Main") as! LoginViewController
            }
            
            it("should have a UIWebView as a view") {
                expect(controller.view).to(beAnInstanceOf(UIWebView))
            }
            
            it("should set itself as the web view delegate") {
                expect(controller.webView.delegate).to(beIdenticalTo(controller))
            }
            
            //TODO: Fix this test
            xit("should make a loadRequest to the login url") {
                expect(controller.webView.request?.URL).to(equal(testURLProvider.urlForPath("/mobile_login")))
            }
            
            describe("viewDidAppear") {
                beforeEach {
                    controller.webView = fakeWebView
                }
                describe("When the token is present in the TokenStore") {
                    beforeEach {
                        fakeTokenStore.token = "some token"
                        controller.viewDidAppear(false)
                    }
                    
                    it("should segue to the PeopleViewController") {
                        expect(controller.seguePerformed).to(beTruthy())
                    }
                }
                describe("When the token is not present in the TokenStore") {
                    beforeEach {
                        controller.viewDidAppear(false)
                    }
                    
                    it("should send a loadRequest message to the WebView") {
                        expect(fakeWebView.loadRequestCallCount).to(equal(1))
                        expect(fakeWebView.loadRequestURL.URL!.absoluteString).to(equal("http://cashcats.biz/mobile_login"))
                    }
                }
            }
            
            describe("View finished loading") {
                class FakeWebView: UIWebView {
                    private var savedRequest: NSURLRequest?
                    override var request: NSURLRequest? {
                        get {
                            return savedRequest
                        }
                        set(request) {
                            savedRequest = request
                        }
                    }
                }
                
                var authToken: String!
                var fakeWebView = FakeWebView()
                
                beforeEach {
                    fakeWebView = FakeWebView()
                    authToken = controller.authToken
                    NSUserDefaults.standardUserDefaults().removeObjectForKey(authToken)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                describe("When wrong URL has been loaded") {
                    beforeEach {
                        fakeWebView.request = NSURLRequest(URL: NSURL(string: "http://example.com/")!)
                        controller.webView = fakeWebView
                        controller.webViewDidFinishLoad(fakeWebView)
                    }
                    
                    it("should not store a token") {
                        expect(fakeTokenStore.token).to(beNil())
                    }
                }
                
                describe("when the right URL has been loaded") {
                    var cookie: NSHTTPCookie!
                    var cookieJar: NSHTTPCookieStorage!
                    
                    beforeEach {
                        let url = testURLProvider.urlForPath(controller.successPath)
                        fakeWebView.request = NSURLRequest(URL: url)
                        cookie = NSHTTPCookie(properties: [
                            NSHTTPCookiePath:"\\",
                            NSHTTPCookieOriginURL: url,
                            NSHTTPCookieName:"_pivots-two_session",
                            NSHTTPCookieValue:"foo"])!
                        cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
                    }
                    
                    describe("When the auth token cookie is present") {
                        beforeEach {
                            cookieJar.setCookie(cookie)
                            controller.webViewDidFinishLoad(fakeWebView)
                        }
                        
                        it("should save the cookie to the TokenStore") {
                            expect(fakeTokenStore.token).to(equal(cookie.value))
                        }
                        
                        it("should segue to the next screen") {
                            expect(controller.seguePerformed).to(beTruthy())
                        }
                    }
                    
                    describe("When the auth token cookie is not present") {
                        beforeEach {
                            cookieJar.deleteCookie(cookie)
                            controller.webViewDidFinishLoad(fakeWebView)
                        }
                        
                        it("should not segue to the next screen") {
                            expect(controller.seguePerformed).to(beFalsy())
                        }
                    }
                }
            }
        }
    }
}

