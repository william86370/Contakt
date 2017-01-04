//
//  AppDelegate.swift
//  Contakt
//
//  Created by william wright  on 7/7/15.
//  Copyright (c) 2015 A.R.C software and enginering. All rights reserved.
//

import UIKit
import Parse
import Bolts
import FBSDKCoreKit


    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        
        
        
        
        var window: UIWindow?
        
        func grabStoryboard() -> UIStoryboard {
            var storyboard = UIStoryboard()
            var height = UIScreen.mainScreen().bounds.size.height
            
            if height == 568 {
                storyboard = UIStoryboard(name: "iphone5", bundle: nil)
            } else {
                storyboard = UIStoryboard(name: "iphone6", bundle: nil)
            }
            return storyboard
        }
        
        
        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
            ParseCrashReporting.enable();
            Parse.setApplicationId("u4gTkPGwWjEiHnJEXQV85o0m0ixTG1ccgVIC3BWa",
                clientKey: "XgzgtUcuehk45oqrpgZiT8vcp5e2n6PhpXAq0lPx")
           
            PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
            
            PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            
            
            var storyboard: UIStoryboard = self.grabStoryboard()
            
            self.window?.rootViewController =
                (storyboard.instantiateInitialViewController() as! UIViewController)
            self.window?.makeKeyAndVisible()
            
            return true
        }
        func application(application: UIApplication,
            openURL url: NSURL,
            sourceApplication: String?,
            annotation: AnyObject?) -> Bool {
                return FBSDKApplicationDelegate.sharedInstance().application(application,
                    openURL: url,
                    sourceApplication: sourceApplication,
                    annotation: annotation)
        }
        
                func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
         FBSDKAppEvents.activateApp()
        }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }




}
