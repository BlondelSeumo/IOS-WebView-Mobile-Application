//
//  MapViewController.swift
//  Universal Webview
//
//  Created by Parth  on 30/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMobileAds

class MapViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,GADInterstitialDelegate {

    @IBOutlet weak var contHedarHeight: NSLayoutConstraint!//64
    @IBOutlet weak var contBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var vwBannerView: UIView!//177

    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var banner : GADBannerView!
    var interstitial: GADInterstitial!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bannerAdsLoad()
        interstitialLoad()
        
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
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
       // annotation.title = "Javed Multani"
       // annotation.subtitle = "current location"
        mapView.addAnnotation(annotation)
        
        
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
