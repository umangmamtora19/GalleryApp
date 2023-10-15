//
//  ProfileVC.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import UIKit

class ProfileVC: UIViewController {
    //    MARK: - OUTLETS
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    
    //    MARK: - VIEW LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //    MARK: - USER METHODS
    static func initFromStoryboard() -> ProfileVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        return vc
    }
    
    func setup() {
        imgProfile.setCircularCorner()
        imgProfile.sd_setImage(with: URL(string: loggedInUser?.profile ?? ""))
        lblName.text = loggedInUser?.name ?? ""
        lblEmail.text = loggedInUser?.email ?? ""
        btnLogout.setCorner(radius: 22)
    }
}

//    MARK: - EVENTS
extension ProfileVC {
    @IBAction func btnLogoutAction(_ sender: UIButton) {
        loggedInUser = nil
        UserDefaults.standard.setValue(Data(), forKey: APPKeys.isLoggedIn)
        scenedelegate?.changeViewController()
    }
}
