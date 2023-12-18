//
//  DetailsViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import UIKit

class DetailsViewUI: UIView {
    private weak var delegate: DetailsViewUIProtocol?
    var stackContainerHeightConstraint = NSLayoutConstraint()
    
    private lazy var scrollContent: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBorder()
        view.backgroundColor = .govinfoWhite
        view.clipsToBounds = true
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
       let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 20
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var shareButton: GovinfoButtonViewUI = {
       let button = GovinfoButtonViewUI()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Buttons.share".localized, for: .normal)
        return button
    }()
    
    required init(delegate: DetailsViewUIProtocol) {
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension DetailsViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        setTargets()
        backgroundColor = .govinfoOrange
    }
    
    func setSubviews(){
        addSubview(scrollContent)
        
        scrollContent.addSubview(containerView)
        
        containerView.addSubview(stackContainerView)
        stackContainerView.addSubview(mainStackView)
        
        containerView.addSubview(shareButton)
    }
    
    func setAutolayout(){
        stackContainerHeightConstraint = stackContainerView.heightAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            scrollContent.topAnchor.constraint(equalTo: topAnchor),
            scrollContent.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollContent.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollContent.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollContent.widthAnchor),
            
            stackContainerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            stackContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackContainerHeightConstraint,
            
            mainStackView.topAnchor.constraint(equalTo: stackContainerView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: stackContainerView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: stackContainerView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: stackContainerView.bottomAnchor, constant: -10),
            
            shareButton.topAnchor.constraint(equalTo: stackContainerView.bottomAnchor, constant: 20),
            shareButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            shareButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            shareButton.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -20),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setTargets() {
        shareButton.addTarget(self, action: #selector(shareToWhatsApp), for: .touchUpInside)
    }
    
    func loadDetails(elements: [GovinfoLabelViewUI]) {
        for element in elements {
            self.mainStackView.addArrangedSubview(element)
        }
        animateStack()
    }
    
    private func animateStack() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut) {
                self.stackContainerHeightConstraint.isActive = false
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc func shareToWhatsApp() {
        delegate?.shareDetailsToWhatsApp()
    }
}
