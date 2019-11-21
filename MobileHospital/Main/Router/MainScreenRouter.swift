//
//  MainScreenRouter.swift
//  portal
//
//  Created by Василий Сомов on 27.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit

protocol MainScreenRouter {
    func popToRootCurrentScreen()
    func popCurrentScreen()
    func navigateTo(_ newController: UIViewController)
    func newRootScreen(_ newController: UIViewController)
    func presentAlert(_ alertController: UIAlertController)
}

class MainScreenRouterImpl: MainScreenRouter, UISplitViewControllerDelegate {
   
    //MARK: - Property list
    private let animationDuration: TimeInterval = 0.4
    var globalRouter: GlobalRouterInput!
    var transitionHandler : UINavigationController! {
        didSet {
            globalRouter = GlobalRouter(withTransitionHandler: transitionHandler)
        }
    }
    
    init(withController controller: UINavigationController) {
        transitionHandler = controller
    }
    
    //MARK: - MainScreenRouter
    
    func navigateTo(_ newController: UIViewController) {
        transitionHandler.pushViewController(newController, animated: true)
    }
    
    func newRootScreen (_ newController: UIViewController) {
        popToRootCurrentScreen()
        transitionHandler.setViewControllers([newController], animated: true)
    }
    
    func popToRootCurrentScreen() {
        transitionHandler?.popToRootViewController(animated: false)
    }
    
    func popCurrentScreen() {
        transitionHandler?.popViewController(animated: false)
    }
    
    func presentAlert(_ alertController: UIAlertController) {
        transitionHandler?.present(alertController, animated: true)
    }
}
