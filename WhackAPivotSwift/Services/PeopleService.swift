import Foundation
import UIKit
import CBGPromise

protocol PeopleService {
    func getPeople() -> Promise<[Person]?, NSError>
}

class PeopleServiceImpl: PeopleService {
    var tokenStore: TokenStore
    let session: NSURLSession
    
    let firstNameKey = "first_name"
    let lastNameKey = "last_name"
    let locationKey = "location_name"
    let imageKey = "photo_url"
    let idKey = "id"
    
    let urlProvider: URLProvider
    let dummyImage = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("dummy", ofType: "png")!)
    
    init(tokenStore: TokenStore, session: NSURLSession, urlProvider: URLProvider) {
        self.tokenStore = tokenStore
        self.session = session
        self.urlProvider = urlProvider
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
        
        let urlRequest = NSMutableURLRequest(URL: urlProvider.getPeopleURL())
        let cookieValue = "_pivots-two_session=\(sessionToken)"
        urlRequest.setValue(cookieValue, forHTTPHeaderField: "Cookie")
        
        let completionHandler: (NSData?, NSURLResponse?, NSError?) -> () = { (data, response, error) in
            
            guard let responseData = data else { fail() ; return }
            
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
                guard let location = dict[self.locationKey] else { continue }
                guard location as? String == "Los Angeles" else { continue }
                let name = "\(dict[self.firstNameKey]! as! String) \(dict["last_name"]! as! String)"
                let image = dict[self.imageKey]! as! String
                let id = dict[self.idKey] as! NSInteger
                people.append(Person(name: name, image: self.imageFromString(image)!, id: id))
            }
            
            promise.resolve(people)
        }
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: completionHandler)
        task.resume()
        return promise
    }
    
    private func imageFromString(string: String) -> UIImage? {
        if let url = NSURL(string: string), data = NSData(contentsOfURL: url) {
          return UIImage(data: data)
        }
        return dummyImage
    }
}
