//
//  OTPVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class OTPVC: UIViewController, OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        if isValid {
            print("valid otp")
            btnGetOtp.isUserInteractionEnabled = true
            btnGetOtp.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        } else {
            print("invalid otp")
            btnGetOtp.isUserInteractionEnabled = false
            btnGetOtp.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
        }
    }
    
    
    @IBOutlet weak var txtFldOtp1: UITextField!
    @IBOutlet weak var txtFldOtp2: UITextField!
    @IBOutlet weak var txtFldOtp3: UITextField!
    @IBOutlet weak var txtFldOtp4: UITextField!
    @IBOutlet weak var txtFldOtp5: UITextField!
    @IBOutlet weak var txtFldOtp6: UITextField!
    
    @IBOutlet weak var OTPStackView: OTPStackView!

    @IBOutlet weak var btnGetOtp: UIButton!
    
    var tokenDict: fetchTokenModel!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OTPStackView.delegate = self
    }
    
    //back button Action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Verify OTP Action
    @IBAction func btnVerifyOTPAction(_ sender: UIButton) {
        print("Otp is:",OTPStackView.getOTP())
        NetworkService.shared.verifyOTP(token: String(tokenDict.token), email: email, code: OTPStackView.getOTP()) { (result) in
            switch result {
            case .success(let token):
                print("Token is:", token)
                let controller = HomeVC.instantiate()
                controller.email = self.email
                self.navigationController?.pushViewController(controller, animated: true)
            case .failure(let error):
                print("error is:", error.localizedDescription)
            }
        }
    }
    
    @IBAction func btnResendOTP(_ sender: UIButton) {
        
    }
    
}
