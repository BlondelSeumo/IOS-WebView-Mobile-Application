//
//  AboutUsViewController.swift
//  Universal Webview
//
//  Created by Parth  on 27/08/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import UIKit
protocol AboutUsPopupDeleget {
    func CloseButton()
   
    
}
class AboutUsViewController: UIViewController {

    
    @IBOutlet weak var tvTextView: UITextView!
    var AboutUsPopup:AboutUsPopupDeleget?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //MARK:- Button actions
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.AboutUsPopup?.CloseButton()
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
