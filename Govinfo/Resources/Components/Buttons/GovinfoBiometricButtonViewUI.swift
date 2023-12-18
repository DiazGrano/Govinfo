//
//  GovinfoBiometricButtonViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import UIKit
import Lottie

protocol GovinfoBiometricButtonViewUIDelegate: AnyObject {
    func biometricStatus(authenticated: Bool)
}

class GovinfoBiometricButtonViewUI: UIView {
    weak var delegate: GovinfoBiometricButtonViewUIDelegate?
    
    private lazy var lottieView: LottieAnimationView = {
        let view = LottieAnimationView(name: GovinfoConstants.lotties.biometric, bundle: .govinfo)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        return view
    }()
    
    required init() {
        super.init(frame: .zero)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GovinfoBiometricButtonViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        setTargets()
        lottieView.play()
        addBorder()
        addGradient()
    }
    
    func setTargets() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(startBiometricAuth))
        tap.cancelsTouchesInView = true
        tap.numberOfTapsRequired = 1
        lottieView.addGestureRecognizer(tap)
    }
    
    func setSubviews(){
        addSubview(lottieView)
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
            lottieView.topAnchor.constraint(equalTo: topAnchor),
            lottieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lottieView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lottieView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func startBiometricAuth() {
        let biometricAuth = BiometricAuthHelper()
        
        biometricAuth.authenticate { [unowned self] authenticated in
            self.delegate?.biometricStatus(authenticated: authenticated)
        } notAvailable: {
            self.delegate?.biometricStatus(authenticated: false)
        }
    }
}
