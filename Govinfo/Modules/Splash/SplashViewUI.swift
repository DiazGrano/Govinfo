//
//  SplashViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit
import Lottie

class SplashViewUI: UIView {
    private weak var delegate: SplashViewUIProtocol?
    
    required init(delegate: SplashViewUIProtocol) {
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        self.backgroundColor = .govinfoOrange
    }
    
    func setSubviews(){
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
        ])
    }
}
