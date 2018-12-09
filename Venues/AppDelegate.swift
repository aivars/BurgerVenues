//
//  AppDelegate.swift
//  Venues
//
//  Created by Aivars Meijers on 24/11/2018.
//  Copyright © 2018 Aivars Meijers. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //create the main navigation controller for the App
        let navController = UINavigationController()
        
        // send navigation controler into the coordinator so that can display VC
        coordinator = MainCoordinator(navigationController: navController)
        
        // take over controll buy coordinator
        coordinator?.start()
        
        // create basic UIVindow  and navigate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }

}

