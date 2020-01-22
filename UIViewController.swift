//
//  UiViewController.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardListener {
    func keyboardShow(keyboardHeight: CGFloat)
    func keyboardHide()
}

@objc protocol KeyboardListenerPrivate {
    func registerShowHideKeyboard()
    @objc func keyboardWillShow(notification: Notification)
    @objc func keyboardWillHide(notification: Notification)
}

extension UIViewController : KeyboardListenerPrivate {
    func registerShowHideKeyboard() {
        if(self is KeyboardListener) {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                                   name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                                   name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo:NSDictionary = notification.userInfo as! NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        (self as? KeyboardListener)?.keyboardShow(keyboardHeight: keyboardHeight)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        (self as? KeyboardListener)?.keyboardHide()
    }
}

// MARK: utils

extension UIViewController {
    
    func setBackButton() {
        let button = UIBarButtonItem.init(title: "Назад", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        button.tintColor = UIColor.blue
        self.navigationItem.backBarButtonItem = button
    } 
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: Routing
extension UIViewController {
    enum MobileHospital: String {
        
        case AuthorizationViewController
        case WorkViewController
        case SinglePatientViewController
        case PatientsViewController
        case ActionsViewController
        case DocumentsViewController
        case ProfileViewController
        case AddPatientViewController
        case SelectDrugViewController
        case ScheduleOperationViewController
        case DischargePatientViewController
        
        private func getController<VC: UIViewController>() -> VC {
            return getStoryBoard().instantiateViewController(withIdentifier: getViewControllerName()) as! VC
        }
        
        private func getViewControllerName() -> String {
            return self.rawValue // <<-- rawValue
        }
        
        private func getStoryBoard() -> UIStoryboard {
            let storyBoard: UIStoryboard
            switch self {
                
            case .AuthorizationViewController:
                storyBoard = UIStoryboard.MobileHospital.Authorization.getStoryBoard()
                break
                
            case .WorkViewController, .ProfileViewController, .DocumentsViewController, .ActionsViewController, .PatientsViewController:
                storyBoard = UIStoryboard.MobileHospital.Work.getStoryBoard()
                break
                
            case .SinglePatientViewController, .ScheduleOperationViewController, .SelectDrugViewController, .DischargePatientViewController:
                storyBoard = UIStoryboard.MobileHospital.SinglePatient.getStoryBoard()
                break
                
            case .AddPatientViewController:
                storyBoard = UIStoryboard.MobileHospital.AddPatient.getStoryBoard()
                break
            }
            
            return storyBoard
        }
        
        func show() {
            if let router: MainScreenRouter = SessionData.MainRouter.getValue() {
                router.navigateTo(getController())
            }
        }
        
        func showAsRoot() {
            if let router: MainScreenRouter = SessionData.MainRouter.getValue() {
                router.newRootScreen(getController())
            }
        }
        
        func show<VC: UIViewController>(withSettings block: (VC) -> Void ) {
            if let router: MainScreenRouter = SessionData.MainRouter.getValue() {
                let viewController: VC = getController()
                block(viewController)
                router.navigateTo(viewController)
            }
        }
        
        func showAsRoot<VC: UIViewController>(withSettings block: (VC) -> Void )  {
            if let router: MainScreenRouter = SessionData.MainRouter.getValue() {
                let viewController: VC = getController()
                block(viewController)
                router.newRootScreen(viewController) 
            }
        }
        
        static func dismiss() {
            if let router: MainScreenRouter = SessionData.MainRouter.getValue() {
                router.popCurrentScreen()
            }
        }
    } 
}
