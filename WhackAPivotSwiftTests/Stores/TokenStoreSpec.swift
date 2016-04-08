import Foundation
import Quick
import Nimble

@testable import WhackAPivotSwift

class TokenStoreSpec: QuickSpec {
    override func spec() {
        describe("TokenStore") {
            let tokenStore = TokenStoreImpl()
            let testToken = "some token"
            beforeEach {
                tokenStore.token = testToken
            }
            
            describe("#setToken") {
                it("should store the token in NSUserDefaults") {
                    expect(NSUserDefaults.standardUserDefaults().stringForKey(tokenStore.authToken)).to(equal(testToken))
                }
            }
            describe("#getToken") {
                describe("When a token is stored") {
                    it("should return the stored token") {
                        expect(tokenStore.token).to(equal(testToken))
                    }
                }
                describe("When no token is stored") {
                    beforeEach {
                        NSUserDefaults.standardUserDefaults().removeObjectForKey(tokenStore.authToken)
                    }
                    it("should return nil") {
                        expect(tokenStore.token).to(beNil())
                    }
                }
            }
        }
    }
}

