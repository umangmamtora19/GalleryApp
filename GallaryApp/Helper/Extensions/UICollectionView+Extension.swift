//
//  UICollectionView+Extension.swift
//  GallaryApp
//
//  Created by Umang on 15/10/23.
//

import UIKit

extension UICollectionView {
//    This comment function is used to reload tableview with some animation
    func reloadWithAnimation() {
        UIView.transition(with: self, duration: 0.35, options: .transitionCrossDissolve, animations: { self.reloadData()
        })
    }
}
