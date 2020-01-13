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
        viewState.hideKeyboard()
        interactor.auth(email: email, password: password, whenError: whenError, complition: { [weak self] in
            guard let `self` = self else { return }
            let user = User()
            user.email = email
            user.password = password
            UserDefaultsInteractor.setUser(user: user)
            FirebaseFirestoreInteractor.getDoctor { (doctor) in
                SessionData.SelectedDoctor.saveValue(doctor)
            }
            self.router.toWork()
        })
    }
    
    
    
}
