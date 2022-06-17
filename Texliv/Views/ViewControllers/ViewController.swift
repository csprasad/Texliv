//
//  ViewController.swift
//  Texliv
//
//  Created by CSPrasad on 08/06/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnGoogleSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Adding shadow to button.
        btnGoogleSignIn.addShadow(15, radius: 8)
    }
    
    @IBAction func btnComingSoon(_ sender: UIButton) {
        Toast.show(message: "We are still working on it..!!", controller: self)
    }
    
}

