//
//  UIView+Extension.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
