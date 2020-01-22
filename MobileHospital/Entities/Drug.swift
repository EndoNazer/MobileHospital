//
//  Drug.swift
//  MobileHospital
//
//  Created by Даниил on 14.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation

class Drug: BaseModel {
    var name: String = ""
    var specialization: String = ""
    var rating: String = ""
    var image: String = ""
    
    init(dictionary: [String: Any]) {
        super.init()
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["Name"] as? String ?? ""
        self.specialization = dictionary["Specialization"] as? String ?? ""
        self.rating = dictionary["Rating"] as? String ?? ""
        self.image = dictionary["Image"] as? String ?? ""
    }
    
    init(id: String, name: String, specialization: String, rating: String, image: String) {
        super.init()
        self.id = id
        self.name = name
        self.specialization = specialization
        self.rating = rating
        self.image = image
    }
    
    override init() {
        
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "Name": name,
            "Specialization": specialization,
            "Rating": rating,
            "Image": image
        ]
    }
    
}
