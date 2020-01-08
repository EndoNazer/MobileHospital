//
//  AuthorizationPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class AuthorizationPresenter {
    
    var interactor: AuthorizationInteractor = AuthorizationInteractor()
    var router: AuthorizationRouter = AuthorizationRouter()
    
    func viewDidLoad() {
        
    }
    
    func auth(email: String, password: String, whenError: @escaping (() -> Void)) {
        if interactor.auth(email: email, password: password, whenError: whenError) {
            router.toWork()
        }
    }
    
}
