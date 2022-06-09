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

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if emailTextField.isValid() {
            buttonGetOtp.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
        } else {
            buttonGetOtp.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
        }
    }
    
    
    
    //Back button action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
