//
//  HomeVC.swift
//  Texliv
//
//  Created by CSPrasad on 10/06/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    
    var email: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = email.components(separatedBy: "@")[0]
    }
    
    @IBAction func btnMenu(_ sender: UIButton) {
        
    }
    
}
