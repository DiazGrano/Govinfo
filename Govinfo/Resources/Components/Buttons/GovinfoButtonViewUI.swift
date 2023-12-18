//
//  GovinfoButtonViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class GovinfoButtonViewUI: UIButton {
    required init() {
        super.init(frame: .zero)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GovinfoButtonViewUI {
    func initComponents() {
        addBorder()
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.minimumScaleFactor = 0.5
        setTitleColor(.govinfoBlack, for: .normal)
        titleLabel?.font = UIFont.getComicFont(16)
        addGradient()
    }
}
