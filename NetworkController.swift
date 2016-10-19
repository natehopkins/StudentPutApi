//
//  NetworkController.swift
//  StudentPutApi
//
//  Created by Nathan Hopkins on 10/19/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

class NetworkController {
    
    //============================
    //  Mark: - Propreties
    //============================
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch = "PATCH"
        case Delete = "Delete"
    }
    
    static func performRequest(for url: URL, httpMethod: HTTPMethod, urlParameters: [String: String]? = nil, body: Data? = nil, completion: ((Data?, Error?) -> Void)? = nil) {
        
        // Build our entire URL
        
        let requestURL = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        // Create and "resume" (aka run) the task
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            completion?(data, error)
        }
        
        dataTask.resume()
    }
    
    static func url(byAdding parameters: [String: String]?, to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap( {URLQueryItem(name: $0.0, value: $0.1 ) } )
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        
        return url
    }
}
