//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Francesco Puntillo on 08/12/2017.
//  Copyright © 2017 FP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let application = Application()
        window?.rootViewController = application.rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

