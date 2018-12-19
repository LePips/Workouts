//
//  AppDelegate.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/28/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = ThisViewController()
        return true
    }

}
