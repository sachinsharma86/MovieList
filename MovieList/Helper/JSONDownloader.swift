//
//  JSONDownloader.swift
//  MovieList
//
//  Created by Sachin on 12/17/18.
//

import Foundation

class JSONDownloader {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    
    typealias jsonTaskCompletionHandler = (JSON?, MovieError?) -> Void
    
    func jsonTask(with request:URLRequest, completionHandler completion:@escaping jsonTaskCompletionHandler) -> URLSessionDataTask{
        
        let task = session.dataTask(with: request) { data, response, error in
            
            //convert to http response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data{
                    do {
                        
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        completion(json, nil)
                        
                    } catch{
                        completion(nil, .jsonConversionFailure)
                    }
                    
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .requestUnsucessful)
            }
        }
        return task
    }
}

