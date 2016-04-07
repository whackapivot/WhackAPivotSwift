import Quick
import Nimble
import Swinject
import WebKit

@testable import WhackAPivotSwift

class LoginViewControllerSpec: SwinjectSpec {
    override func spec() {
        describe("LoginViewController") {
            var controller: LoginViewController!
            var fakePeopleService: FakePeopleService!
            let testURLProvider = URLProviderImpl(baseURL: "http://cashcats.biz")
            
            beforeEach {
                fakePeopleService = FakePeopleService()
                fakePeopleService.assemblePeopleReturns()
                
                self.testContainer.registerForStoryboard(LoginViewController.self) { _, controller in
                    controller.urlProvider = testURLProvider
                    controller.peopleService = fakePeopleService
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
            
            describe("View did finish navigation") {
                var authToken: String!
                
                class FakeUIWebView: UIWebView {
                    var myRequest: NSURLRequest!
                    
                    init(url: NSURL) {
                        self.myRequest = NSURLRequest(URL: url)
                        super.init(frame: CGRect())
                    }
                    
                    required init(coder: NSCoder) {
                        fatalError("init(coder:) has not been implemented")
                    }
                    
                    override var request: NSURLRequest {
                        return myRequest
                    }
                }
                
                var fakeWebView: FakeUIWebView!
                
                beforeEach {
                    authToken = controller.authToken
                    NSUserDefaults.standardUserDefaults().removeObjectForKey(authToken)
                    NSUserDefaults.standardUserDefaults().synchronize()
                }
                
                describe("When wrong URL has been loaded") {
                    beforeEach {
                        fakeWebView = FakeUIWebView(url: NSURL(string: "http://example.com/")!)
                        controller.webViewDidFinishLoad(fakeWebView)
                    }
                    
                    it("should not store an auth token in NSUserDefaults") {
                        expect(NSUserDefaults.standardUserDefaults().objectForKey(authToken)).to(beNil())
                    }
                }
                
                describe("when the right URL has been loaded") {
                    let url = testURLProvider.urlForPath("/mobile_success")
                    var cookie: NSHTTPCookie!
                    var cookieJar: NSHTTPCookieStorage!
                    
                    beforeEach {
                        fakeWebView = FakeUIWebView(url: url)
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
                        
                        it("should store the auth token in NSUserDefaults") {
                            expect(NSUserDefaults.standardUserDefaults().stringForKey(authToken)).to(equal(cookie.value))
                        }
                        
                        it("should tell the people service to assemble the people") {
                            expect(fakePeopleService.assemblePeopleCallCount).to(equal(1))
                        }
                        
                        describe("When the people are assembled") {
                            beforeEach {
                                fakePeopleService.assemblePeopleArgsForCall(0)()
                            }
                            
                            it("should segue to the next screen") {
                                expect(controller.seguePerformed).to(beTruthy())
                            }
                        }
                    }
                    
                    describe("When the auth token cookie is not present") {
                        beforeEach {
                            cookieJar.deleteCookie(cookie)
                            controller.webViewDidFinishLoad(fakeWebView)
                        }
                        
                        it("should not store the auth token in NSUserDefaults") {
                            expect(NSUserDefaults.standardUserDefaults().stringForKey(authToken)).to(beNil())
                        }
                        
                        it("should not tell the people service to assemble the people") {
                            expect(fakePeopleService.assemblePeopleCallCount).to(equal(0))
                        }
                    }
                }
            }
        }
    }
}

