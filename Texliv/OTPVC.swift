//
//  OTPVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class OTPVC: UIViewController {
    
    @IBOutlet weak var txtFldOtp1: UITextField!
    @IBOutlet weak var txtFldOtp2: UITextField!
    @IBOutlet weak var txtFldOtp3: UITextField!
    @IBOutlet weak var txtFldOtp4: UITextField!
    @IBOutlet weak var txtFldOtp5: UITextField!
    @IBOutlet weak var txtFldOtp6: UITextField!

    @IBOutlet weak var btnGetOtp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        txtFldOtp1.delegate = self
        txtFldOtp2.delegate = self
        txtFldOtp3.delegate = self
        txtFldOtp4.delegate = self
        txtFldOtp5.delegate = self
        txtFldOtp6.delegate = self
        txtFldOtp1.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        txtFldOtp2.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        txtFldOtp3.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        txtFldOtp4.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        txtFldOtp5.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
        txtFldOtp6.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)
    }
    
    //back button Action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Verify OTP Action
    @IBAction func btnVerifyOTPAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnResendOTP(_ sender: UIButton) {
        //service call again
    }
    
}


//OTP TEXTFILEDS
extension OTPVC: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
           let currentString = (textField.text ?? "") as NSString
           let newString = currentString.replacingCharacters(in: range, with: string)
        
            if ((textField.text?.count)! < 1 ) && (string.count > 0) {
                
                if textField == txtFldOtp1 {
                    txtFldOtp2.becomeFirstResponder()
                }
                
                if textField == txtFldOtp2 {
                    txtFldOtp3.becomeFirstResponder()
                }
                
                if textField == txtFldOtp3 {
                    txtFldOtp4.becomeFirstResponder()
                }
                
                if textField == txtFldOtp4 {
                    txtFldOtp5.becomeFirstResponder()
                }
                if textField == txtFldOtp5 {
                    txtFldOtp6.becomeFirstResponder()
                }
                if textField == txtFldOtp6 {
                    txtFldOtp6.resignFirstResponder()
                    btnGetOtp.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.2431372549, blue: 0.2745098039, alpha: 1)
                }
                
                textField.text = string
                return false
            } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
                if textField == txtFldOtp2 {
                    txtFldOtp1.becomeFirstResponder()
                }
                if textField == txtFldOtp3 {
                    txtFldOtp2.becomeFirstResponder()
                }
                if textField == txtFldOtp4 {
                    txtFldOtp3.becomeFirstResponder()
                }
                if textField == txtFldOtp5 {
                    txtFldOtp4.becomeFirstResponder()
                }
                if textField == txtFldOtp6 {
                    txtFldOtp5.becomeFirstResponder()
                    btnGetOtp.backgroundColor = #colorLiteral(red: 0.5725490196, green: 0.6039215686, blue: 0.6705882353, alpha: 1)
                }
                if textField == txtFldOtp1 {
                    txtFldOtp1.resignFirstResponder()
                }
                
                textField.text = ""
                return false
            }
        
        return newString.count <= maxLength
    }
}
