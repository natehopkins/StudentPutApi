//
//  Student.swift
//  StudentPutApi
//
//  Created by Nathan Hopkins on 10/19/16.
//  Copyright © 2016 NathanHopkins. All rights reserved.
//

import Foundation

struct Student {
    
    //============================
    //  Mark: - Properties
    //============================
    
    let name: String
}

extension Student {
    
    //============================
    //  Mark: - Properties
    //============================
    
    static let keyName = "name"
    
    var dictionaryRepresentation: [String: Any] {
        
        // name value --> ["name": "Jeff"]
        return [Student.keyName: name as Any]
    }
    
    var jsonData: Data? {
        
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
    
    //============================
    //  Mark: - Initializers
    //============================
    
    init?(dictionary: [String: String]) {
        guard let name = dictionary[Student.keyName] else {
            return nil
        }
        
        self.init(name: name)
        
    }
    
}
