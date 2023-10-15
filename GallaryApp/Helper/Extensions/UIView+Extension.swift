//
//  UIView+Exatension.swift
//  GallaryApp
//
//

import UIKit

extension UIView {
//    This common function is used to make any view circular
    func setCircularCorner() {
        self.layer.cornerRadius = self.frame.width / 2
    }
    
//    This common function is used to give corners to any view
    func setCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
//    This common function is used to give shadow to any view
    func setShadow(shadowColor: UIColor, shadowOpacity: Float, shadowRadius: CGFloat, shadowOffset: CGSize) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:2)
        self.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: bounds.maxY - layer.shadowRadius, width: bounds.width, height: layer.shadowRadius)).cgPath
    } 
}
