//
//  GovinfoLoader.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit
import Lottie

class GovinfoLoaderViewUI: UIView {
    private lazy var lottieView: LottieAnimationView = {
        let view = LottieAnimationView(name: GovinfoConstants.lotties.cat, bundle: .govinfo)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.loopMode = .loop
        view.animationSpeed = 1.7
        view.alpha = 0
        return view
    }()
    
    private lazy var loadingMessage: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .govinfoBlack
        label.font = .getComicFont(12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GovinfoLoaderViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        backgroundColor = .govinfoOrange.withAlphaComponent(0)
    }
    
    func setSubviews(){
        addSubview(lottieView)
        addSubview(loadingMessage)
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
            lottieView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            lottieView.heightAnchor.constraint(equalTo: lottieView.widthAnchor),
            lottieView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lottieView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingMessage.topAnchor.constraint(equalTo: lottieView.bottomAnchor),
            loadingMessage.leadingAnchor.constraint(equalTo: lottieView.leadingAnchor),
            loadingMessage.trailingAnchor.constraint(equalTo: lottieView.trailingAnchor),
        ])
    }
}
extension GovinfoLoaderViewUI {
    func playLoader(message: String) {
        DispatchQueue.main.async {
            self.lottieView.play()
            self.loadingMessage.text = message
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = .govinfoOrange.withAlphaComponent(0.4)
                self.lottieView.alpha = 1
            }
        }
    }
    
    func stopLoader(completion: (() -> ())?) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2) {
                self.alpha = 0
            } completion: { _ in
                self.lottieView.stop()
                completion?()
            }
        }
    }
}
