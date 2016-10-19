//
//  StudentController.swift
//  StudentPutApi
//
//  Created by Nathan Hopkins on 10/19/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

class StudentController {
    

//    work:
//        -Endpoints
//        -Function for getting students
//        -Function for adding a student
    
    //============================
    //  Mark: - Properties
    //============================
    
    static var baseURL = URL(string: "https://names-e4301.firebaseio.com/students")
    
    // adds to .json to the base url
    static var getterEndpoint = baseURL?.appendPathExtension("json")
    
    //============================
    //  Mark: - Methods
    //============================
    
    static func send(studentWithName name: String, completion: ((_ success: Bool) -> Void)? = nil) {
        
        // Create a student instance
        let student = Student(name: name)
        
        // Add the student name to the URL
        guard let url = baseURL?.appendingPathComponent(name).appendingPathExtension("json") else { return }
        
        // Call the NetworkController to send the data to FireBase
        NetworkController.performRequest(for: url, httpMethod: .Put, body: student.jsonData) { (data, error) in
            
            var success = false
            
            defer {
                
                if let completion = completion {
                    completion(success)
                }
                
            }
            
            guard let responseDataString = String(data: data!, encoding: .utf8) else { return }
            
            if let error = error {
                NSLog("Error: \(error.localizedDescription)")
                return
            } else if responseDataString.contains("error") {
                
                NSLog("Error: \(responseDataString)")
            } else {
                
                print("Successfully saved data to the endpoint.  \nResponse: \(responseDataString)")
                success = true
            }
            
        }
        
        // See whether or not it woked
    }
    
}
