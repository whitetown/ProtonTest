//
//  AppDelegate.swift
//  ProtonTest
//
//  Created by Robert Patchett on 07.02.19.
//  Copyright © 2019 Proton Technologies AG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let splitViewController = window?.rootViewController as? UISplitViewController
        splitViewController?.delegate = self
        return true
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }

}

