//
//  ViewController.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    //    MARK: - OUTLETS
    @IBOutlet weak var viewGoogle: UIView!
    
    //    MARK: - VARIABLES
    private var loginVM = LoginViewModel()
    private var bindings = Set<AnyCancellable>()
    
    //    MARK: - VIEW LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //    MARK: - USER METHODS
    static func initFromStoryboard() -> LoginVC {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        return vc
    }
    
    func setup() {
        viewGoogle.setCorner(radius: 10)
        viewGoogle.setShadow(shadowColor: .black.withAlphaComponent(0.5), shadowOpacity: 5, shadowRadius: 5, shadowOffset: CGSize(width: 5, height: 5))
    }
}

//    MARK: - EVENTS
extension LoginVC {
    @IBAction func btnGoogleAction(_ sender: UIButton) {
        loginVM.googleLoginAction()
        loginVM.loginResult.sink { error in
            
        } receiveValue: { [weak self] in
            guard let `self` = self else { return }
            scenedelegate?.changeViewController()
        }.store(in: &bindings)

    }
}
