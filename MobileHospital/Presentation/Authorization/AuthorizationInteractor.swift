//
//  AuthorizationInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class AuthorizationInteractor {
    
    private var isAuthorized: Bool = false
    
    func auth(email: String, password: String, whenError: @escaping (() -> Void)) -> Bool {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (result, error) in
            guard let `self` = self else { return }
            if error != nil {
                whenError()
                self.isAuthorized = false
                print("\(error?.localizedDescription)")
            } else {
                self.isAuthorized = true
            }
        }
        
        if isAuthorized {
            return true
        }
        
        return false
    }
    
}
