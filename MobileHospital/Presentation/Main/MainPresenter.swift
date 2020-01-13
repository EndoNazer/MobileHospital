//
//  NavigationViewPresenter.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit 

class MainPresenter<T: MainView>:BasePresenter<T> {
    
    var interactor = MainInteractor()
    var router = MainRouter()
   
    func viewDidLoad(controller: UINavigationController) {
        let router = MainScreenRouterImpl(withController: controller)
        SessionData.MainRouter.saveValue(router)
        initData()
        eventsListening()
    }
    
    func viewDidAppear() {
        if isUserExist() {
            UIViewController.MobileHospital.WorkViewController.showAsRoot()
        } else {
            UIViewController.MobileHospital.AuthorizationViewController.showAsRoot()
        }
    }
    
    func viewWillDisappear() {
        unRegisterEvents()
    }
    
    func eventsListening() {
        registerEventOnMainThread(Events.MessageEvent) { (message: String?) in
            if let message = message {
                self.viewState.showMessage(message)
            }
        }
        registerEventOnMainThread(Events.ShowLoader) { (_: Void?) in
            self.viewState.showLoader()
        }
        registerEventOnMainThread(Events.HideLoader) { (_: Void?) in
            self.viewState.hideLoader()
        }
        registerEventOnMainThread(Events.UnauthEvent) { (_: Void?) in
            self.removeUserData()
            UIViewController.MobileHospital.AuthorizationViewController.showAsRoot()
        }
    }
    
    func isUserExist() -> Bool {
        let email: String? = SessionData.AuthEmail.getValue()
        let password: String? = SessionData.AuthPassword.getValue()
        return email != nil && password != nil
    }

    private func initData() {
        if(SharedData.DeviceId.string().isEmpty) {
            let uuid: String = UIDevice.current.identifierForVendor?.uuidString ?? "unknow"
            SharedData.DeviceId.saveValue(uuid)
            SharedData.AppId.saveValue("\(uuid)\(Date().ticks)")
        }
        
        if let user = UserDefaultsInteractor.getUser() {
            SessionData.AuthEmail.saveValue(user.email)
            SessionData.AuthPassword.saveValue(user.password)
            FirebaseFirestoreInteractor.getDoctor { (doctor) in
                SessionData.SelectedDoctor.saveValue(doctor)
                UIImage().downloaded(from: doctor.image) { (img) in
                    SessionData.DoctorAvatar.saveValue(img)
                }
            }
        } else {
            removeUserData()
        }
    }

    fileprivate func removeUserData() {
        SessionData.removeUserData()
        SharedData.removeUserData()
        UserDefaultsInteractor.removeUser()
    }
    
}
