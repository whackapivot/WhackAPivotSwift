import Foundation

protocol URLProvider {
    func urlForPath(path: String) -> NSURL
    func getPeopleURL() -> NSURL
}

class URLProviderImpl: URLProvider {
    let baseURL: String
    let peoplePath = "/api/users.json"
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getPeopleURL() -> NSURL { return urlForPath(peoplePath) }
    
    func urlForPath(path: String) -> NSURL {
        return NSURL(string: "\(baseURL)\(path)")!
    }
}
