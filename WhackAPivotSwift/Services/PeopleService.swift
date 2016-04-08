import Foundation
import UIKit
import CBGPromise

protocol PeopleService {
    func getPeople() -> Promise<[Person]?, NSError>
}

class PeopleServiceImpl: PeopleService {
    var tokenStore: TokenStore
    let session: NSURLSession
    
    init(tokenStore: TokenStore, session: NSURLSession) {
        self.tokenStore = tokenStore
        self.session = session
    }
    
    func getPeople() -> Promise<[Person]?, NSError> {        
        let promise = Promise<[Person]?, NSError>()

        func fail() {
            promise.reject(NSError(domain: "PeopleServiceGetPeople", code: 0, userInfo: [:]))
            tokenStore.token = nil
        }
        
        guard let sessionToken = tokenStore.token else {
            promise.reject(NSError(domain: "PeopleServiceGetPeople", code: 0, userInfo: [:]))
            return promise
        }
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://pivots.pivotallabs.com/api/users.json")!)
        let cookieValue = "_pivots-two_session=\(sessionToken)"
        urlRequest.setValue(cookieValue, forHTTPHeaderField: "Cookie")
        
        let completionHandler: (NSData?, NSURLResponse?, NSError?) -> () = { (data, response, error) in
            
            guard let responseData = data else { return }
            
            guard error == nil else { fail() ; return }
            
            let result: AnyObject
            do {
                result = try NSJSONSerialization.JSONObjectWithData(responseData,
                                                                    options: [])
            } catch  { fail() ; return }
            
            guard result is NSArray else {
                promise.reject(NSError(domain: "PeopleServiceGetPeople", code: 0, userInfo: [:]))
                return
            }
            
            let resultAsArray = result as! NSArray
            
            var people: [Person] = []
            for dict in resultAsArray {
                guard let location = dict["location_name"] else { continue }
                guard location as? String == "Los Angeles" else { continue }
                let name = "\(dict["first_name"]! as! String) \(dict["last_name"]! as! String)"
                let image = dict["photo_url"]! as! String
                people.append(Person(name: name, image: image))
            }
            
            promise.resolve(people)
        }
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: completionHandler)
        task.resume()
        return promise
    }
}
