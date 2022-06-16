//
//  UITextfield+Extension.swift
//  Texliv
//
//  Created by CSPrasad on 16/06/22.
//

import UIKit



extension UITextField {
    
    func getOTP(fields: [UITextField]) -> String {
        var otp = ""
        for textfield in fields {
            otp += textfield.text ?? ""
        }
        return otp
    }
}
