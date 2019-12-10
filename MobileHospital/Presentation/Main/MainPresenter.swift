//
//  NavigationViewPresenter.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit 

class MainPresenter<T: MainView>:BasePresenter<T> {
   
    func viewDidLoad(controller: UINavigationController) {
        let router = MainScreenRouterImpl(withController: controller)
        SessionData.MainRouter.saveValue(router)
        initData()
        eventsListening()
    }
    
    func viewDidAppear() {
        if isUserExist() {
            if let doctor: Doctor = SessionData.SelectedDoctor.getValue() {
                //let workTab: WorkTab = client.isBillTo() ? .debt : .promo
                UIViewController.MobileHospital.ViewController.showAsRoot { (vc: ViewController) in
                    //vc.switchTab(to: workTab)
                }
            } else {
                UIViewController.MobileHospital.ViewController.showAsRoot()
            }
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
        
//        let users = DBRepository.userDao().getAllUsers()
//        if let user = users.first {
//            let phone = user.login
//            let clientId = SharedData.SelectedClientId.integer()
//            SessionData.SelectedUser.saveValue(user)
//            SessionData.SelectedClient.saveValue(DBRepository.clientDao().findClientById(id: Int64(clientId)))
//            SessionData.Phone.saveValue(phone)
//            SessionData.Token.saveValue(user.token)
//            let orders = DBRepository.orderDao().getAllOrders()
//            SessionData.LastOrderDeliveries.saveValue(orders)
//        } else {
//            removeUserData()
//        }
    }

    fileprivate func removeUserData() {
        SessionData.removeUserData()
        SharedData.removeUserData()
        //DBRepository.removeUserData()
    }
}
