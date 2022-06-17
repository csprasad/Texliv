//
//  EmailVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class EmailVC: UIViewController {
    
    /// IBOutlets for UI Referance
    @IBOutlet weak var buttonGetOtp: UIButton!
    @IBOutlet weak var emailTextField: FloatingTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonGetOtp.addShadow(15, radius: 8) ///Adding shadow to button
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)        ///Textfield editing change action target for enabling button OTP.
    }
    
    ///textfield editingChange func
    ///if email is valid then button color will change accordingly and it will enable button user interaction as well.
    /// updatung button color & unser interaction
    @objc func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.isValid() {
            buttonGetOtp.isUserInteractionEnabled = true
            buttonGetOtp.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        } else {
            buttonGetOtp.isUserInteractionEnabled = false
            buttonGetOtp.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
        }
    }
    
    ///Back button action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    ///API calling for get otp from networkservice class
    ///if success pushing vc to next screen OTPVC!!!
    @IBAction func btnGetOTP(_ sender: UIButton) {
        NetworkService.shared.fetchToken(email: emailTextField.text ?? "") { (result) in
            switch result {
            case .success(let res):
                print("Token is:", res.results?.token ?? "0")
                guard let token = res.results else {return}
                let controller = OTPVC.instantiate()
                controller.tokenDict = token
                controller.email = self.emailTextField.text ?? ""
                self.navigationController?.pushViewController(controller, animated: true)
            case .failure(let error):
                print("error is:", error.localizedDescription)
                Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
    

}
