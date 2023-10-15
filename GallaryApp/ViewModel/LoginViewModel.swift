//
//  LoginViewModel.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import Foundation
import SocialLoginSwift
import Combine

class LoginViewModel {
    
    //    MARK: - VARIABLES
    var socialLogin = SocialLogin()
    let loginResult = PassthroughSubject<Void, Error>()

    
    //    MARK: - USER METHODS
    // Call this function to login with google
    func googleLoginAction() {
        socialLogin.clientID = googleClientID
        let controller = CommonUtility.shared.getTopViewController()!
        socialLogin.googlesignIn(view: controller) { success, message, user in
            if success {
                loggedInUser = User(id: user?.social_id ?? "", name: user?.name ?? "", email: user?.email ?? "", profile: user?.profile ?? "")
                
                let encoder = JSONEncoder()
                let data = try! encoder.encode(loggedInUser.self)
                UserDefaults.standard.set(data, forKey: APPKeys.isLoggedIn)
                
                self.loginResult.send(())
            } else {
            }
        }
    }
}
