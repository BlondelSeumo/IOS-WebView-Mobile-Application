//
//  SupportPopupViewController.swift
//  Universal Webview
//
//  Created by Parth  on 27/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
protocol SupportPopupDeleget {
    func CloseButton()
    func EmailButton(sender:SupportPopupViewController)
    func CallButton(sender:SupportPopupViewController)
    
}
class SupportPopupViewController: UIViewController {

     var supportPopup:SupportPopupDeleget?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK:- Button Actions
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.supportPopup?.CloseButton()
           
    }
    
    @IBAction func btnEmailTapped(_ sender: Any) {
        self.supportPopup?.EmailButton(sender: self)
    }
    
    @IBAction func btnCallTapped(_ sender: Any) {
        self.supportPopup?.CallButton(sender: self)
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
