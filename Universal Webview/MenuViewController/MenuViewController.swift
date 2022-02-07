//
//  MenuViewController.swift
//  AKSwiftSlideMenu
//
//  Created by Ashish on 21/09/15.
//  Copyright (c) 2015 Kode. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    /**
    *  Array to display menu options
    */
    
    
    /**
    *  Transparent button to hide menu
    */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?


    @IBOutlet weak var vwHome: UIView!
    @IBOutlet weak var vwSetting: UIView!
    @IBOutlet weak var vwLocation: UIView!
    
    
    @IBOutlet weak var vwPrivacyPolicy: UIView!
    @IBOutlet weak var vwShareApp: UIView!
    @IBOutlet weak var vwRateApp: UIView!
    
    @IBOutlet weak var vwMoreApp: UIView!
    
    
    @IBOutlet weak var vwLogin: UIView!
    @IBOutlet weak var vwContactUs: UIView!
    @IBOutlet weak var imgLogin: UIImageView!
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!

    
    
    
    @IBOutlet weak var contHedarHeight: NSLayoutConstraint!//64
    @IBOutlet weak var contBannerHeight: NSLayoutConstraint!
    @IBOutlet weak var vwBannerView: UIView!
    var adsOpen:Bool = false
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapHomeGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapHomeButton(_:)))
        vwHome.addGestureRecognizer(tapHomeGesture)


        let tapSettingGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapSettingButton(_:)))
        vwSetting.addGestureRecognizer(tapSettingGesture)

        
        let tapMapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapMapButton(_:)))
        vwLocation.addGestureRecognizer(tapMapGesture)
        
        
        //let tapMixupGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapMixupButton(_:)))
      // vwMixup.addGestureRecognizer(tapMixupGesture)


        let tapShareAppGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapShareAppButton(_:)))
        vwShareApp.addGestureRecognizer(tapShareAppGesture)

        let tapRateAppGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapRateAppButton(_:)))
        vwRateApp.addGestureRecognizer(tapRateAppGesture)
        
        let tapMoreAppGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapMoreButton(_:)))
        vwMoreApp.addGestureRecognizer(tapMoreAppGesture)



        let tapContactUsGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapContactUsButton(_:)))
        vwContactUs.addGestureRecognizer(tapContactUsGesture)

      //  imgLogo.layer.borderWidth = 2
     //   imgLogo.layer.borderColor = UIColor.white.cgColor
        imgLogo.layer.cornerRadius = 20
        imgLogo.clipsToBounds = true
        vwLogin.isHidden = true
    }


    @objc func tapHomeButton(_ sender: UIButton) {
    let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       self.navigationController?.pushViewController(newViewcontroller, animated: true)
    }
  
    @objc func tapSettingButton(_ sender: UIButton) {      
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.navigationController?.pushViewController(newViewcontroller, animated: true)
    }
    @objc func tapMapButton(_ sender: UIButton) {
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        self.navigationController?.pushViewController(newViewcontroller, animated: true)
    }

    
    @objc func tapShareAppButton(_ sender: UIButton) {
        
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
    @objc func tapRateAppButton(_ sender: UIButton) {
       SKStoreReviewController.requestReview()
    }
    @objc func tapContactUsButton(_ sender: UIButton) {
        sendEmail()
    }
    
    @objc func tapMoreButton(_ sender: UIButton) {
        if let url = URL(string: MoreAppUrl),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.openURL(url)
        }
    }
    @objc func tapLoginButton(_ sender: UIButton) {
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()

//        if UserDefaults.standard.value(forKey: "WMToken") != nil
//        {
//            imgLogin.image = UIImage(named: "logout")
//            lblLogin.text! = "Logout"
//        }else
//        {
//            imgLogin.image = UIImage(named: "login")
//            lblLogin.text! = "Login"
//
//        }
    }

    func updateArrayMenuOptions(){
        arrayMenuOptions = []




    }
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["\(Email)"])
            mail.setMessageBody("<p>Name: Set Status Quotes</p>", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }

        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    

}
