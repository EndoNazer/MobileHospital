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
    
    func auth(email: String, password: String, whenError: @escaping (() -> Void)) {
        viewState.hideKeyboard()
        interactor.auth(email: email, password: password, whenError: whenError, complition: { [weak self] in
            guard let `self` = self else { return }
            let user = User()
            user.email = email
            user.password = password
            UserDefaultsInteractor.setUser(user: user)
            SessionData.AuthEmail.saveValue(email)
            SessionData.AuthPassword.saveValue(password)
            FirebaseFirestoreInteractor.getDoctorFromSessionDataValues { (doctor) in
                SessionData.SelectedDoctor.saveValue(doctor)
                UIImage().downloaded(from: doctor.image, complition: { (img) in
                    SessionData.DoctorAvatar.saveValue(img)
                }){}
            }
            self.router.toWork()
        })
    }
    
    
    
}
