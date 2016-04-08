import Foundation

typealias Token = String

protocol TokenStore {
    var token: Token? { get set }
}

class TokenStoreImpl: TokenStore {
    let authToken = "authToken"
    var token: Token? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey(authToken)
        }
        set(token) {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(token, forKey: authToken)
            defaults.synchronize()
        }
    }
}