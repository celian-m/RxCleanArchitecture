//
//  AppDelegate.swift
//  GitHubSample
//
//  Created by Célian MOUTAFIS on 27/09/2017.
//  Copyright © 2017 mouce. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller : UIViewController
        if ProcessInfo.processInfo.arguments.contains("TEST") {
            controller = UIViewController()
        }else{
            controller = RepoListRouter.instantiateController()}
        let navigationController = UINavigationController(rootViewController: controller)
        //navigationController.isNavigationBarHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
        //return true
    }
}

