//
//  AppDelegate.swift
//  swift(NSOperation)
//
//  Created by 范云飞 on 2017/9/7.
//  Copyright © 2017年 范云飞. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
    }


}

