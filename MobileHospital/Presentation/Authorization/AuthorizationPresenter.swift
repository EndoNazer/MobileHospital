//
//  AuthorizationPresenter.swift
//  MobileHospital
//
//  Created by Даниил on 08.01.2020.
//  Copyright © 2020 Даниил. All rights reserved.
//

import Foundation
import Firebase

class AuthorizationPresenter<T: AuthorizationView>: BasePresenter<T> {
    
    var interactor: AuthorizationInteractor = AuthorizationInteractor()
    var router: AuthorizationRouter = AuthorizationRouter()
    
    func viewDidLoad() {
        
    }
    
    func auth(email: String, password: String, whenError: @escaping (() -> Void)) {
        interactor.auth(email: email, password: password, whenError: whenError)
        if interactor.isAuthorized {
            let user = User()
            user.email = email
            user.password = password
            UserDefaultsInteractor.setUser(user: user)
            router.toWork()
        }
    }
    
}
