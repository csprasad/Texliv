//
//  HomeVC.swift
//  Texliv
//
//  Created by CSPrasad on 10/06/22.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelReward: UILabel!
    @IBOutlet weak var labelNxtGol: UILabel!
    @IBOutlet weak var btnRefer: UIButton!
    @IBOutlet weak var rewardView: UIView!
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var referView: UIView!
    
    ///User info Dictionary - this data will come from previous screen while pushing VC.
    var userinfo: userInfoModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///Calling func for UI & User information update once ui is loaded.
        updateUserInfo()
        updateUI()
    }
    
    
    ///Updating user information to View directly from userinfo Dictionary.
    func updateUserInfo() {
        labelName.text = "\(userinfo.firstName) \(userinfo.lastName)"
        labelEmail.text = userinfo.email
        labelReward.text = "\(userinfo.rewards)"
        labelNxtGol.text = "\(userinfo.nextGoal)"
        guard let url = URL(string: userinfo.avatar) else {return}
        avatar.load(url: url)
    }
    
    ///Adding shadows to all the buttons.
    func updateUI() {
        avatar.addShadow(75, radius: 8)
        rewardView.addShadow(15, radius: 5)
        goalView.addShadow(15, radius: 5)
        referView.addShadow(15, radius: 8)
    }
    
    
    ///Side menu & contact us button coming soon toast
    @IBAction func btnMenu(_ sender: UIButton) {
        Toast.show(message: "We are working on updates..!!", controller: self)
    }
    
    ///Refer now button action this will present the UIActivityViewController with Ites to share. here im sharing basic text with some links in it.
    @IBAction func btnReferNow(_ sender: UIButton) {
        let referMessage = userinfo.referralMessage
        let textShare = [ referMessage ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
