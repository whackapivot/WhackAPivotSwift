//
//  PivotsService.swift
//  WhackAPivotSwift
//
//  Created by Pivotal on 3/24/16.
//  Copyright © 2016 Pivotal. All rights reserved.
//

import Foundation
import UIKit

protocol PeopleService {
    func assemblePeople(completion: () -> ())
    func getPeople() -> [Person]
}

class PeopleServiceImpl: PeopleService {
    var people: [Person]!
    
    func assemblePeople(completion: () -> ()) {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let sessionToken = NSUserDefaults.standardUserDefaults().stringForKey("authToken")
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://pivots.pivotallabs.com/api/users.json")!)
        let cookieValue = "_pivots-two_session=\(sessionToken!)"
        urlRequest.setValue(cookieValue, forHTTPHeaderField: "Cookie")
        
        let completionHandler: (NSData?, NSURLResponse?, NSError?) -> () = { (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            guard error == nil else {
                print("error calling GET on /posts/1")
                print(error)
                return
            }
            let result: AnyObject
            do {
                result = try NSJSONSerialization.JSONObjectWithData(responseData,
                                                                    options: [])
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
            guard result is NSArray else {
                print("unexpected JSON returned")
                return
            }
            
            let resultAsArray = result as! NSArray
            
            self.people = []
            for dict in resultAsArray {
                guard let location = dict["location_name"] else { continue }
                guard location as? String == "Los Angeles" else { continue }
                let name = "\(dict["first_name"]! as! String) \(dict["last_name"]! as! String)"
                let image = dict["photo_url"]! as! String
                self.people.append(Person(name: name, image: image))
            }
            
            completion()
        }
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: completionHandler)
        task.resume()
    }

    func getPeople() -> [Person] {
        return people
    }
}
