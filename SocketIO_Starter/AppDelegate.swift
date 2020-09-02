//
//  AppDelegate.swift
//  SocketIO_Starter
//
//  Created by Abhi Makadiya on 21/08/20.
//  Copyright © 2020 Abhi Makadiya. All rights reserved.
//

import UIKit

var appDelegate = UIApplication.shared.delegate as? AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 13.0, *) {} else {
            //for IOS 12 or lower
            SocketIOManager.shared.establishConnection()
        }
        setupInitialNavigation(nil)
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneDidEnterBackground
        SocketIOManager.shared.closeConnection()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Not called under iOS 13 - See SceneDelegate sceneWillEnterForeground
        SocketIOManager.shared.establishConnection()
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


}

//MARK: - Other Stuffs
extension AppDelegate {
    
    func setupInitialNavigation(_ win: UIWindow?) {
        if #available(iOS 13.0, *) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController()
            navigationController.navigationBar.isHidden = true
            win?.rootViewController = navigationController
            win?.makeKeyAndVisible()
        } else {
            window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController()
            navigationController.navigationBar.isHidden = true
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
    }
    
}
