//
//  SceneDelegate.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import UIKit

var scenedelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        changeViewController()
    }
    
    func changeViewController() {
        let data = UserDefaults.standard.value(forKey: APPKeys.isLoggedIn) as? Data ?? Data()
        if data.count > 0 {
            loggedInUser = try! JSONDecoder().decode(User.self, from: data)
            let vc = GalleryVC.initFromStoryboard()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        } else {
            let vc = LoginVC.initFromStoryboard()
            let nav = UINavigationController(rootViewController: vc)
            window?.rootViewController = nav
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        CoreDataManager.saveToMainContext()
    }


}

