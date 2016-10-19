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
    
    static var baseURL = URL(string: "https://names-e4301.firebaseio.com/students")!
    
    // adds to .json to the base url
    static var getterEndpoint = baseURL.appendingPathExtension("json")
    
    //============================
    //  Mark: - Methods
    //============================
    
    static func send(studentWithName name: String, completion: ((_ success: Bool) -> Void)? = nil) {
        
        // Create a student instance
        let student = Student(name: name)
        
        // Add the student name to the URL
        let url = baseURL.appendingPathComponent(name).appendingPathExtension("json")
        
        // Call the NetworkController to send the data to FireBase
        NetworkController.performRequest(for: url, httpMethod: .Put, body: student.jsonData) { (data, error) in
            
            var success = false
            
            defer {
                
                if let completion = completion {
                    completion(success)
                }
                
            }
            // See whether or not it woked
            
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
        
    }
    
    static func fetchStudents(completion: @escaping ([Student]) -> Void) {
        
        NetworkController.performRequest(for: StudentController.getterEndpoint, httpMethod: .Get) { (data, error) in
            
            guard let data = data else {
                completion([])
                return
            }
            
            guard let studentDict = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: [String: String]] else {
                
                completion([])
                return
            }
            
            let students = studentDict.flatMap { Student(dictionary: $0.1) }
            completion(students)
        }
        
    }
    
    
}
