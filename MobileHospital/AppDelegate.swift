//
//  AppDelegate.swift
//  MobileHospital
//
//  Created by Даниил on 19.11.2019.
//  Copyright © 2019 Даниил. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configureNavigationBar()
        configureStatusBar()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func configureStatusBar() {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    private func configureNavigationBar() {
        
        let navigationBarAppearace = UINavigationBar.appearance()
        
        let navigationBarTitleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18.0, weight: .regular)]
        navigationBarAppearace.titleTextAttributes = navigationBarTitleAttributes
        
        let barButtonItemsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
            .foregroundColor: UIColor.brown
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonItemsAttributes, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonItemsAttributes, for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonItemsAttributes, for: .selected)
        UIBarButtonItem.appearance().tintColor = UIColor.brown
    }


}

