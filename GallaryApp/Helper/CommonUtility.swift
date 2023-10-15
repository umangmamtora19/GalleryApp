//
//  CommonUtility.swift
//  GallaryApp
//
//

import UIKit

//  This is sigleton class for general purpose in app
class CommonUtility {
    static let shared = CommonUtility()
    private let indicator = UIActivityIndicatorView()
    
//    This is common function to show loading indicator in thoughout the app
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.indicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            guard let window = scenedelegate?.window else { return }
            self.indicator.center = window.center
            window.addSubview(self.indicator)
            self.indicator.startAnimating()
        }
    }

//    This is common function to hide loading indicator from thoughout the app
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    func getTopViewController() -> UIViewController? {
        scenedelegate?.window?.visibleViewController()
    }
    
    func appPrint(_ data: Any) {
        print(data)
    }
    
}
