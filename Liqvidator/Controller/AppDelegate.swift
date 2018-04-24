//
//  AppDelegate.swift
//  Liqvidator
//
//  Created by Бекболат Куанышев on 03.03.2018.
//  Copyright © 2018 Bekbolat. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = UINavigationController(rootViewController: LoginViewController())
        homeViewController.view.backgroundColor = UIColor.black
        UINavigationBar.appearance().barTintColor = UIColor.clear
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        window!.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        
        return true
    }


}

