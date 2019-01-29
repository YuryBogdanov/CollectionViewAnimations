//
//  AppDelegate.swift
//  CollectionViewAnimations
//
//  Created by Christian Noon on 10/29/15.
//  Copyright © 2015 Noondev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - App State Methods
    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = {
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = ViewController()
            window.backgroundColor = UIColor.white
            window.makeKeyAndVisible()
            
            return window
        }()
    }
}
