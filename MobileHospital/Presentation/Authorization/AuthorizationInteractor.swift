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
    
    var isAuthorized: Bool = false
    
    override func execute() -> Response<Void> {
       
        return Response()
    }
    
    func auth(email: String, password: String, whenError: @escaping (() -> Void)) {
        jobs += self.background({[weak self] (ui, execute) in
            guard let `self` = self else { return }
            if self.isAuthorized == false {
                Events.ShowLoader.post()
            }
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
            Events.HideLoader.post()
        })
    }
    
}
