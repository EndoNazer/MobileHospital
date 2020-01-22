//
//  WorkViewController.swift
//  portal
//
//  Created by Василий Сомов on 28.11.2018.
//  Copyright © 2018 Василий Сомов. All rights reserved.
//

import UIKit

enum WorkTab: Int {
    //case patients, action, documents, account
    case patients, documents, account
}

class WorkViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackButton()
        self.navigationController?.isNavigationBarHidden = false
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
    }
    
    private func setBarTitle(at selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            self.title = "Пациенты"
//        case 1:
//            self.title = "Действия"
        case 1:
            self.title = "Документы"
        case 2:
            self.title = "Профиль"
        default:
            self.title = ""
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setBarTitle(at: tabBarController.selectedIndex)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selectionAlowed = true
        return selectionAlowed
    }
    
    func switchTab(to tab: WorkTab) {
        selectedIndex = tab.rawValue
        setBarTitle(at: selectedIndex)
    }
    
}
