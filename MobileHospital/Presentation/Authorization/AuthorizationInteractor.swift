//
//  AuthorizationInteractor.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class AuthorizationInteractor: BaseInteractor {//<T: AuthDataResult>: BaseInteractor<T> {
    
    func auth(email: String, password: String, whenError: @escaping (() -> Void), complition: @escaping (() -> Void)) {
        jobs += self.background({(ui, execute) in
            Events.ShowLoader.post()
            Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
                if error != nil {
                    whenError()
                    print("\(error?.localizedDescription)")
                } else {
                    complition()
                }
                Events.HideLoader.post()
            }
        })
    }
    
}
