//
//  UIView+Extensions.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

extension UIView {
    func addGradient(_ topColor: UIColor = UIColor.govinfoWhite, _ bottomColor: UIColor = UIColor.govinfoGrayDark, isFilled: Bool = true) {
        DispatchQueue.main.async {
            let subLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer })
            subLayer?.removeFromSuperlayer()
            
            let gradient = CAGradientLayer()
            gradient.colors = [topColor.cgColor, bottomColor.cgColor]
            gradient.locations = [isFilled ? 0.7 : 0, isFilled ? 1 : 0.3]
            gradient.frame = self.bounds
            self.clipsToBounds = true
            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    func addShadow() {
        setShadowStatus(isDefault: true)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false
    }
    
    func setShadowStatus(isDefault: Bool) {
        layer.shadowColor = isDefault ? UIColor.govinfoBlack.cgColor : UIColor.govinfoRed.cgColor
    }
    
    func addBorder() {
        layer.borderWidth = GovinfoConstants.Dimensions.borderWidth
        layer.borderColor = UIColor.govinfoBlack.cgColor
        layer.cornerRadius = GovinfoConstants.Dimensions.cornerRadius
    }
}
