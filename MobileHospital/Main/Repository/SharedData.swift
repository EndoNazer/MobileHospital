//
//  SharedData.swift
//  MobileHospital
//
//  Created by Даниил on 21.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import Foundation

enum SharedData: String {
    case DeviceId
    case AppId
    case SelectedClientId
}

extension SharedData: Hashable {
    func integer() -> Int {
        return UserDefaults.standard.integer(forKey: "\(self.rawValue)")
    }
    
    func float() -> Float {
        return UserDefaults.standard.float(forKey: "\(self.rawValue)")
    }
    
    func string() -> String {
        return UserDefaults.standard.string(forKey: "\(self.rawValue)") ?? ""
    }
    
    func boolean() -> Bool {
        return UserDefaults.standard.bool(forKey: "\(self.rawValue)")
    }

    func saveValue<T>(_ value: T) {
        UserDefaults.standard.setValue(value, forKey: "\(self.rawValue)")
    }

    func remove() {
        UserDefaults.standard.removeObject(forKey: "\(self.rawValue)")
    }
    
    static func removeUserData() {
        SelectedClientId.remove()
        UserDefaults.standard.synchronize()
    }

    // Remove All
//        let domain = Bundle.main.bundleIdentifier!
//        UserDefaults.standard.removePersistentDomain(forName: domain)
//        UserDefaults.standard.synchronize()

}
