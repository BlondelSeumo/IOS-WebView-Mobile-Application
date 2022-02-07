//
//  SettingViewController.swift
//  Universal Webview
//
//  Created by Parth on 30/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMobileAds
class SettingViewController: UIViewController,UNUserNotificationCenterDelegate {

    @IBOutlet weak var NotificationSwitch: UISwitch!
    
    @IBOutlet weak var contHedarHeight: NSLayoutConstraint!//64
    @IBOutlet weak var contBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var vwBannerView: UIView!//177
    
    var banner : GADBannerView!
    var interstitial: GADInterstitial!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //iphone x and x mex support
        if UIScreen.main.bounds.size.height == 812 || UIScreen.main.bounds.size.height == 896 || UIScreen.main.bounds.size.height == 926 || UIScreen.main.bounds.size.height == 844
        {
            contHedarHeight.constant = 85
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            contBannerHeight.constant = 95
        }else
        {
            contBannerHeight.constant = 50
        }
        bannerAdsLoad()
       
        
        //Notification
        if #available(iOS 10.0, *) {
            
            // SETUP FOR NOTIFICATION FOR iOS >= 10.0
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async(execute: {
                        UIApplication.shared.registerForRemoteNotifications()
                    })
                }
            }
            
        } else {
            
            // SETUP FOR NOTIFICATION FOR iOS < 10.0
            
            let settings = UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            
            // This is an asynchronous method to retrieve a Device Token
            // Callbacks are in AppDelegate.swift
            // Success = didRegisterForRemoteNotificationsWithDeviceToken
            // Fail = didFailToRegisterForRemoteNotificationsWithError
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    //MARK:- button actions
    @IBAction func swSwitchTapped(_ sender: Any) {
        if NotificationSwitch.isOn
        {
            print("On")
             UIApplication.shared.registerForRemoteNotifications()
            
        }
        if !NotificationSwitch.isOn
        {
            print("Off")
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    
    //MARK:- notification Delegate
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // ...register device token with our Time Entry API server via REST
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //print("DidFaildRegistration : Device token for push notifications: FAIL -- ")
        //print(error.localizedDescription)
    }
    
    //MARK:- google ads
    func bannerAdsLoad(){
        
        banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        banner.adUnitID = bannerAds
        banner.rootViewController = self
        let req : GADRequest = GADRequest()
        // req.testDevices = ["fcaaac022557f086c093d27ee62dc1b6", kGADSimulatorID]
        banner.load(req)
        // banner.frame = CGRect(x: 0, y: view.bounds.height - banner.frame.size.height, width: banner.frame.size.width, height: banner.frame.size.height)
        vwBannerView.addSubview(banner)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
