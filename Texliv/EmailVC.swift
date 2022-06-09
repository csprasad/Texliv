//
//  EmailVC.swift
//  Texliv
//
//  Created by CSPrasad on 09/06/22.
//

import UIKit

class EmailVC: UIViewController {
    
    // IBOutlets for UI Referance
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Back button action
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
