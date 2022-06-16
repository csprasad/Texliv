//
//  EmailVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class EmailVC: UIViewController {
    
    // IBOutlets for UI Referance
    @IBOutlet weak var buttonGetOtp: UIButton!
    @IBOutlet weak var emailTextField: FloatingTextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.isValid() {
            buttonGetOtp.isUserInteractionEnabled = true
            buttonGetOtp.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        } else {
            buttonGetOtp.isUserInteractionEnabled = false
            buttonGetOtp.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
        }
    }
    
    //Back button action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnGetOTP(_ sender: UIButton) {
        
        NetworkService.shared.fetchToken(email: emailTextField.text ?? "") { (result) in
            switch result {
            case .success(let token):
                print("Token is:", token)
                let controller = OTPVC.instantiate()
                controller.tokenDict = token
                controller.email = self.emailTextField.text ?? ""
                self.navigationController?.pushViewController(controller, animated: true)
            case .failure(let error):
                print("error is:", error.localizedDescription)            }
        }
    }
    

}
