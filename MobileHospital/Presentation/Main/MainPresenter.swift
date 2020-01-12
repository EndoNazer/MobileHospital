//
//  NavigationViewPresenter.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit 

class MainPresenter<T: MainView>:BasePresenter<T> {
    
    var router = MainRouter()
   
    func viewDidLoad(controller: UINavigationController) {
        let router = MainScreenRouterImpl(withController: controller)
        SessionData.MainRouter.saveValue(router)
        initData()
        eventsListening()
    }
    
    func viewDidAppear() {
        if isUserExist() {
//            if let doctor: Doctor = SessionData.SelectedDoctor.getValue() {
//                //let workTab: WorkTab = client.isBillTo() ? .debt : .promo
//                //UIViewController.MobileHospital.ViewController.showAsRoot { (vc: ViewController) in
//                    //vc.switchTab(to: workTab)
//                }
//            } else {
//                //UIViewController.MobileHospital.ViewController.showAsRoot()
//            }
        } else {
            UIViewController.MobileHospital.AuthorizationViewController.show()
            //UIViewController.MobileHospital.AuthLoginViewController.show()
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
            //UIViewController.MobileHospital.AuthLoginViewController.showAsRoot()
        }
    }
    
    func isUserExist() -> Bool {
        let user: User? = SessionData.SelectedDoctor.getValue()
        return user != nil
    }
    
//    func isClientSelected() -> Bool {
//        let client: Client? = SessionData.SelectedClient.getValue()
//        return client != nil
//    }

    private func initData() {
        if(SharedData.DeviceId.string().isEmpty) {
            let uuid: String = UIDevice.current.identifierForVendor?.uuidString ?? "unknow"
            SharedData.DeviceId.saveValue(uuid)
            SharedData.AppId.saveValue("\(uuid)\(Date().ticks)")
        }
        
        if let user = UserDefaultsInteractor.getUser() {
            SessionData.AuthEmail.saveValue(user.email)
            SessionData.AuthPassword.saveValue(user.password)
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
