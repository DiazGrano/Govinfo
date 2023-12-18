//
//  UIFont+Extensions.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

extension UIFont {
    static func getComicFont(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Comic Sans MS", size: size) ?? systemFont(ofSize: size, weight: .medium)
    }
}
