//
//  AppDelegate.swift
//  BlazeSdkTest
//
//  Created by Ram on 01/08/20.
//  Copyright © 2020 Ram. All rights reserved.
//

import UIKit
import BlazeSdk

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        BlazeClient.shared.clientID =  "b501cd4d-bf62-4e26-a383-31827fd250a6"
        BlazeClient.shared.clientSecrete = "021f6589-130b-4e3f-99ef-e2c3b4944cc7"
        BlazeClient.shared.accesToken = "" // if you already registred
        BlazeClient.shared.emailId = "ddcblaze@gmail.com"  // if you already registred

//            1. clientID: "b501cd4d-bf62-4e26-a383-31827fd250a6"
//            2. clientSecrete id: "021f6589-130b-4e3f-99ef-e2c3b4944cc7"
//            3. emailId: ddcblaze@gmail.com
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


}

