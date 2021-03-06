//
//  AppDelegate.swift
//  Gift Exchange
//
//  Created by Greg Willis on 10/17/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppCenter.start(
            withAppSecret: "d45c306c-2a11-4d8a-a916-ff3932da9640",
            services: [Analytics.self, Crashes.self]
        )
        return true
    }

}

