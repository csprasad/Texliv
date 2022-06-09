//
//  OTPVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class OTPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //back button Action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Verify OTP Action
    @IBAction func verifyOTPAction(_ sender: UIButton) {
    }
    
}
