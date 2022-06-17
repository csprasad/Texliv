//
//  OTPVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class OTPVC: UIViewController, OTPDelegate {
    
    //OTP Delegate function.
    ///OTP is valid all textfields are filled and color and interaction will be enabled
    ///OTP is invalid all textfields are not filled and color and interaction will be disabled
    func didChangeValidity(isValid: Bool) {
        if isValid {
            btnGetOtp.isUserInteractionEnabled = true
            btnGetOtp.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        } else {
            btnGetOtp.isUserInteractionEnabled = false
            btnGetOtp.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
        }
    }
    
    @IBOutlet weak var OTPStackView: OTPStackView!

    @IBOutlet weak var btnGetOtp: UIButton!
    
    var tokenDict: fetchTokenModel!
    var email: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnGetOtp.addShadow(15, radius: 8)   ///Adding shadow to button
        OTPStackView.delegate = self ///OTPStackView delegate linking to self to access data here.
    }
    
    ///back button Action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    ///Verify OTP Button Action
    @IBAction func btnVerifyOTPAction(_ sender: UIButton) {
        APIServiceCallingForOTPVerification() //Api calling from func
    }
    
    ///Resend OTP button action
    @IBAction func btnResendOTP(_ sender: UIButton) {
        APIServiceCallingForOTPVerification() //Api calling from func
    }
    
    ///OTP verification API Request to Network service class.
    ///Checking token valid response then pushing to next screen.
    ///basic data sending to next VC for display.
    func APIServiceCallingForOTPVerification() {
        print("Otp is:",OTPStackView.getOTP()) ///check otp.
        
        NetworkService.shared.verifyOTP(token: String(tokenDict.token), email: email, code: OTPStackView.getOTP()) { (result) in
            switch result {
            case .success(let token):
                print("Token is:", token)
                
                if let isLogin = token.results?.isLogin {
                    print(isLogin,"current", self.tokenDict.isLogin, "previous")
                    if self.tokenDict.isLogin && isLogin {
                        let controller = HomeVC.instantiate()
                        controller.userinfo = token.results?.user
                        self.navigationController?.pushViewController(controller, animated: true)
                    } else {
                        Toast.show(message: "\(token.message), but isLogin is not true", controller: self)
                    }
                } else {
                    Toast.show(message: "\(token.message)", controller: self)
                }
            case .failure(let error):
                print("error is:", error.localizedDescription)
                Toast.show(message: error.localizedDescription, controller: self)
                
            }
        }
    }
    
}
