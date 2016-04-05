import Foundation

protocol URLProvider {
    func urlForPath(path: String) -> NSURL
}

class URLProviderImpl: URLProvider {
    let baseURL: String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func urlForPath(path: String) -> NSURL {
        return NSURL(string: "\(baseURL)\(path)")!
    }
}
