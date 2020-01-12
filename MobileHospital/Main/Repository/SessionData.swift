//
//  SessionData.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit

var instanseData: [SessionData: Any] = [:]

enum SessionData {
    case MainRouter // MainScreenRouter.class
    case AuthEmail
    case AuthPassword //String.class
    case SelectedDoctor // Doctor.class
    
    //EXAMPLE FOR FILTER
    //case ClientFilterData // ClientFilterData.class
    
}

extension SessionData {
    
    func getValue<T>() -> T? {
        return instanseData[self] as? T
    }
    
    func getValue<T>(defaultValue: T) -> T {
        return instanseData[self] as? T ?? defaultValue
    }
    
    func saveValue<T>(_ value: T) {
        instanseData[self] = value
    }

    func remove() {
        instanseData.removeValue(forKey: self)
    }
    
    static func removeUserData() {
        SelectedDoctor.remove()
    }
    
}
