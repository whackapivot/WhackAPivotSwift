import Quick
import Nimble
import Swinject
import WebKit

@testable import WhackAPivotSwift

class LoginViewControllerSpec: SwinjectSpec {
    override func spec() {
        describe("LoginViewController") {
            var controller: LoginViewController!
            var fakeControllerDelegate: FakeLoginViewControllerDelegate!
            
            beforeEach {
                fakeControllerDelegate = FakeLoginViewControllerDelegate()
                
                self.testContainer.registerForStoryboard(LoginViewController.self) { _, controller in                }
                
                
                controller = self.startController("LoginViewController", storyboardName: "Main") as! LoginViewController
                controller.delegate = fakeControllerDelegate
                
                
            }
            
            it("should have a webview that delegates to it") {
                expect(controller.webView.navigationDelegate).to(beIdenticalTo(controller))
            }
            
            describe("Successful login") {
                beforeEach {
                    
                }
                it("should call the delegate method indicating success") {
                }
            }
        }
    }
}

//#import "PVTLoginViewController.h"
//#import "PVTInjectorModule.h"
//#import "PVTURLProvider.h"
//#import "PVTHTTPInterface.h"

//using namespace Cedar::Matchers;
//using namespace Cedar::Doubles;
//
//SPEC_BEGIN(PVTLoginViewControllerSpec)
//
//describe(@"PVTLoginViewController", ^{
//__block id<BSInjector, BSBinder> injector;
//__block PVTLoginViewController *controller;
//__block PVTURLProvider *urlProvider;
//__block id<PVTLoginViewControllerDelegate> delegate;
//__block UIWebView *webView;
//
//beforeEach(^{
//injector = (id<BSInjector, BSBinder>)[Blindside injectorWithModule:[PVTInjectorModule module]];
//
//urlProvider = [[PVTURLProvider alloc] init];
//[urlProvider setupWithBaseURL:[NSURL URLWithString:@"http://cashcats.biz"]];
//[injector bind:[PVTURLProvider class] toInstance:urlProvider];
//
//delegate = nice_fake_for(@protocol(PVTLoginViewControllerDelegate));
//controller = [injector getInstance:[PVTLoginViewController class]];
//controller.delegate = delegate;
//
//[[NSUserDefaults standardUserDefaults] removeObjectForKey:kAuthToken];
//
//controller.view should_not be_nil;
//webView = controller.webView;
//spy_on(webView);
//});
//
//it(@"should have a webview that delegates to it", ^{
//controller.webView.delegate should be_same_instance_as(controller);
//});
//
//describe(@"viewWillAppear:", ^{
//beforeEach(^{
//[controller viewWillAppear:NO];
//});
//
//it(@"should have the webview load the users URL", ^{
//webView.request.URL should equal([urlProvider URLforPath:@"/mobile_login"]);
//});
//});
//
//describe(@"-webViewDidFinishLoad:", ^{
//describe(@"when the wrong URL has been loaded", ^{
//beforeEach(^{
//NSURL *url = [NSURL URLWithString:@"https://google.com"];
//webView stub_method(@selector(request)).and_return([NSURLRequest requestWithURL:url]);
//[controller webViewDidFinishLoad:webView];
//});
//
//it(@"should not store an auth token in NSUserDefaults", ^{
//[[NSUserDefaults standardUserDefaults] objectForKey:kAuthToken] should be_nil;
//});
//});
//
//describe(@"when the right URL has been loaded", ^{
//__block NSHTTPCookie *cookie;
//__block NSHTTPCookieStorage *cookieJar;
//
//beforeEach(^{
//NSURL *url = [urlProvider URLforPath:@"/mobile_success"];
//webView stub_method(@selector(request)).and_return([NSURLRequest requestWithURL:url]);
//cookie = [NSHTTPCookie cookieWithProperties:@{NSHTTPCookiePath:@"\\",
//NSHTTPCookieOriginURL: url,
//NSHTTPCookieName:@"_pivots-two_session",
//NSHTTPCookieValue:@"foo"}];
//cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//});
//
//describe(@"when the auth token cookie is present", ^{
//beforeEach(^{
//[cookieJar setCookie:cookie];
//
//[controller webViewDidFinishLoad:webView];
//});
//
//it(@"should store the auth token in NSUserDefaults", ^{
//[[NSUserDefaults standardUserDefaults] objectForKey:kAuthToken] should equal(cookie.value);
//});
//
//it(@"should send a global notification for view controllers to catch", ^{
//delegate should have_received(@selector(loginViewControllerDidLogin));
//});
//});
//
//describe(@"when the auth token cookie is not present", ^{
//beforeEach(^{
//[cookieJar deleteCookie:cookie];
//
//[controller webViewDidFinishLoad:webView];
//});
//
//it(@"should not store the auth token in NSUserDefaults", ^{
//[[NSUserDefaults standardUserDefaults] objectForKey:kAuthToken] should_not equal(cookie.value);
//});
//
//it(@"should not trigger a notification", ^{
//delegate should_not have_received(@selector(loginViewControllerDidLogin));
//});
//
//});
//});
//});
//});
//
//SPEC_END
