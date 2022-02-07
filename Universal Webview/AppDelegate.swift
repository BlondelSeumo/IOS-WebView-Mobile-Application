//
//  AppDelegate.swift
//  Universal Webview
//
//  Created by Parth  on 27/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import UserNotifications
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var deviceTokenString = String()
  

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
      
        
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, error in
            })
        } else {
            // Fallback on earlier versions
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        // .badge,
        let settings2: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        
        application.registerUserNotificationSettings(settings2)
        application.registerForRemoteNotifications()
        
        
        
     
//        
//        OneSignal.initWithLaunchOptions(launchOptions, appId: "\(oneSignalId)", handleNotificationReceived: { (notification) in
//            print("Received Notification - \(String(describing: notification?.payload.notificationID))")
//        }, handleNotificationAction: { (result) in
//            let payload: OSNotificationPayload? = result?.notification.payload
//            var fullMessage: String? = payload?.body
//            if payload?.additionalData != nil {
//                var additionalData: [AnyHashable: Any]? = payload?.additionalData
//                if additionalData!["actionSelected"] != nil {
//                    fullMessage = fullMessage! + "\nPressed ButtonId:\(String(describing: additionalData!["actionSelected"]))"
//                }
//            }
//            
//            print(fullMessage)
//        }, settings: [kOSSettingsKeyAutoPrompt : true])
        
        // Remove this method to stop OneSignal Debugging
          OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)

          // OneSignal initialization
          OneSignal.initWithLaunchOptions(launchOptions)
          OneSignal.setAppId("\(oneSignalId)")

          // promptForPushNotifications will show the native iOS notification permission prompt.
          // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
          OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
          })

        
        
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

