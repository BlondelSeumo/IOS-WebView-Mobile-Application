//
//  WebViewController.swift
//  Universal Webview
//
//  Created by Parth  on 27/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import WebKit
import GoogleMobileAds

class WebViewController: UIViewController,WKNavigationDelegate,GADInterstitialDelegate {

    @IBOutlet weak var contHedarHeight: NSLayoutConstraint!//64
    @IBOutlet weak var contBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var vwBannerView: UIView!
    
    @IBOutlet weak var vwView: UIView!

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
   
    var banner : GADBannerView!
    var interstitial: GADInterstitial!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var webView: WKWebView!

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
        interstitialLoad()
        
        indicator.startAnimating()
        indicator.isHidden = false   
        

        
      
        let url = NSURL(string: websiteURL)
        let request = NSURLRequest(url: url! as URL)
        
        // init and load request in webview.
        webView = WKWebView(frame: view.layer.bounds)
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        self.vwView.addSubview(webView)
        self.vwView.sendSubviewToBack(webView)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.isHidden = false
        indicator.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.isHidden = true
        indicator.stopAnimating()
    }
    //MARK:- google add
    @objc func interstitialLoad()  {
        self.interstitial = createAndLoadInterstitial()
    }
    func createAndLoadInterstitial() -> GADInterstitial? {
        interstitial = GADInterstitial(adUnitID: InterstitialAds)
        
        guard let interstitial = interstitial else {
            return nil
        }
        
        let request = GADRequest()
        // request.testDevices = [ kGADSimulatorID ]
        interstitial.load(request)
        interstitial.delegate = self
        
        return interstitial
    }
    public func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully")
        
     
            ad.present(fromRootViewController: self)
    
        
        
    }
    
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Fail to receive interstitial")
        
    }
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
       
    }
    
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
