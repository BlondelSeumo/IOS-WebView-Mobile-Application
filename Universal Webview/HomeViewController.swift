//
//  HomeViewController.swift
//  Universal Webview
//
//  Created by Parth on 27/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import GoogleMobileAds

class HomeViewController: BaseViewController,SupportPopupDeleget,AboutUsPopupDeleget,MFMailComposeViewControllerDelegate {
 
    @IBOutlet weak var contViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contHedarHeight: NSLayoutConstraint!//64
    @IBOutlet weak var contBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var vwBannerView: UIView!//177

    
    @IBOutlet weak var vwSupport: UIView!
    @IBOutlet weak var vwAboutus: UIView!
    @IBOutlet weak var vwWebview: UIView!
    @IBOutlet weak var vwShareApp: UIView!
    @IBOutlet weak var vwRateApp: UIView!
    
    var banner : GADBannerView!
    var interstitial: GADInterstitial!
     var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DesignPart()
        bannerAdsLoad()
        addSlideMenuButton()
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        print(screenWidth)
        print(screenHeight)
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
        //5s
        if UIScreen.main.bounds.size.height == 568
        {
            contViewHeight.constant = 107
        }
        // 7
        if UIScreen.main.bounds.size.height == 667
        {
            contViewHeight.constant = 140
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        
        vwSupport.isUserInteractionEnabled = true
        let tapSupport = UITapGestureRecognizer(target: self, action: #selector(self.supportHandleTap(_:)))
        vwSupport.addGestureRecognizer(tapSupport)
        
        let tapAboutus = UITapGestureRecognizer(target: self, action: #selector(self.aboutusHandleTap(_:)))
        vwAboutus.addGestureRecognizer(tapAboutus)
        
        let tapWebview = UITapGestureRecognizer(target: self, action: #selector(self.webviewHandleTap(_:)))
        vwWebview.addGestureRecognizer(tapWebview)
        
        let tapShareApp = UITapGestureRecognizer(target: self, action: #selector(self.shareHandleTap(_:)))
        vwShareApp.addGestureRecognizer(tapShareApp)
        
        let tapRateApp = UITapGestureRecognizer(target: self, action: #selector(self.rateHandleTap(_:)))
        vwRateApp.addGestureRecognizer(tapRateApp)
        
    }
    
    // function which is triggered when handleTap is called
    @objc func supportHandleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        
        var myPopupViewController:SupportPopupViewController!
        myPopupViewController = SupportPopupViewController(nibName:"SupportPopupViewController", bundle: nil)
        self.view.alpha = 1.0
        myPopupViewController.supportPopup = self
        self.presentpopupViewController(popupViewController: myPopupViewController, animationType: .BottomTop, completion: { () -> Void in
        })
        
    }
    
    @objc func aboutusHandleTap(_ sender: UITapGestureRecognizer) {
        print("Hello World")
        
        var myPopupViewController:AboutUsViewController!
        myPopupViewController = AboutUsViewController(nibName:"AboutUsViewController", bundle: nil)
        self.view.alpha = 1.0
        myPopupViewController.AboutUsPopup = self
        self.presentpopupViewController(popupViewController: myPopupViewController, animationType: .BottomTop, completion: { () -> Void in
        })
        
    }
    @objc func webviewHandleTap(_ sender: UITapGestureRecognizer) {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = mainStoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func shareHandleTap(_ sender: UITapGestureRecognizer) {
        
        let shareText = "Download App Now"
        let shareText3:URL = URL(string: "\(AppUrl)")!
        if let image = UIImage(named: "logo") {
            let vc = UIActivityViewController(activityItems: [shareText,shareText3, image], applicationActivities: [])
            if let popoverController = vc.popoverPresentationController{
                popoverController.sourceView = self.view
                popoverController.sourceRect = self.view.frame
                
            }
            self.present(vc, animated: true)
        }
        
    }
    @objc func rateHandleTap(_ sender: UITapGestureRecognizer) {
          SKStoreReviewController.requestReview()
    }
    
    //MARK:- support Deleget
    func CloseButton() {
        self.dismissPopupViewController(animationType: SLpopupViewAnimationType.BottomTop)
    }
    
    func EmailButton(sender: SupportPopupViewController) {
           sendEmail()
    }
    
    func CallButton(sender: SupportPopupViewController) {
        let url: NSURL = URL(string: "TEL://+919712166670")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    //MARK:- Button actions
    
    @IBAction func btnFacebookTapped(_ sender: Any) {
        if let url = URL(string: FacebookPageURL),
            UIApplication.shared.canOpenURL(url){
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func btnInnstagramTapped(_ sender: Any) {
        if let url = URL(string: InstagramPageURL),
            UIApplication.shared.canOpenURL(url){
              UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
 
    @IBAction func btnTwitterTapped(_ sender: Any) {
        if let url = URL(string: TwitterPageURL),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    //MARK:- mail funcations
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["\(Email)"])
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    
    //MARK:- google add
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
    
    //MARK:- design Part
    
    func DesignPart() {
        vwSupport.layer.shadowColor = UIColor.gray.cgColor
        vwSupport.layer.shadowOpacity = 1
        vwSupport.layer.shadowOffset = CGSize.zero
        vwSupport.layer.shadowRadius = 5
        vwSupport.layer.cornerRadius = 10
        
        
        vwAboutus.layer.shadowColor = UIColor.gray.cgColor
        vwAboutus.layer.shadowOpacity = 1
        vwAboutus.layer.shadowOffset = CGSize.zero
        vwAboutus.layer.shadowRadius = 5
        vwAboutus.layer.cornerRadius = 10
        
        
        vwWebview.layer.shadowColor = UIColor.gray.cgColor
        vwWebview.layer.shadowOpacity = 1
        vwWebview.layer.shadowOffset = CGSize.zero
        vwWebview.layer.shadowRadius = 5
        vwWebview.layer.cornerRadius = 10
        
        
        vwShareApp.layer.shadowColor = UIColor.gray.cgColor
        vwShareApp.layer.shadowOpacity = 1
        vwShareApp.layer.shadowOffset = CGSize.zero
        vwShareApp.layer.shadowRadius = 5
        vwShareApp.layer.cornerRadius = 10
        
        
        vwRateApp.layer.shadowColor = UIColor.gray.cgColor
        vwRateApp.layer.shadowOpacity = 1
        vwRateApp.layer.shadowOffset = CGSize.zero
        vwRateApp.layer.shadowRadius = 5
        vwRateApp.layer.cornerRadius = 10
        
        
        
       
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
