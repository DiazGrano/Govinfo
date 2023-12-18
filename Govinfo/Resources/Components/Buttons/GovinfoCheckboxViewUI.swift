//
//  GovinfoCheckboxViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import UIKit

@objc protocol GovinfoCheckboxViewUIDelegate: AnyObject {
    func checkBoxDidCheck(status: Bool)
}

class GovinfoCheckboxViewUI: UIView {
    weak var delegate: GovinfoCheckboxViewUIDelegate?
    private(set) var status: Bool = false
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    private lazy var checkboxButton: UIView = {
        let button = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.govinfoBlack.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .getComicFont(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .govinfoBlack
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    
    required init() {
        super.init(frame: .zero)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GovinfoCheckboxViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        setTargets()
        setStatus(status: false)
    }
    
    func setSubviews() {
        addSubview(checkboxButton)
        addSubview(titleLabel)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            checkboxButton.topAnchor.constraint(equalTo: topAnchor),
            checkboxButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkboxButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 25),
            checkboxButton.heightAnchor.constraint(equalToConstant: 25),

            titleLabel.topAnchor.constraint(equalTo: checkboxButton.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: checkboxButton.bottomAnchor)
        ])
       
    }
    
    func setTargets() {
        let tapped = UITapGestureRecognizer(target: self, action: #selector(updateStatus))
        tapped.numberOfTapsRequired = 1
        addGestureRecognizer(tapped)
    }
    
    func setStatus(status: Bool) {
        DispatchQueue.main.async {
            if status {
                self.checkboxButton.addGradient(.govinfoOrangeLight, .govinfoOrange)
            }  else {
                self.checkboxButton.addGradient(.govinfoGrayDark, .govinfoWhite, isFilled: false)
            }
            
            self.status = status
            self.delegate?.checkBoxDidCheck(status: status)
        }
    }
    
    @objc func updateStatus() {
       setStatus(status: !status)
    }
}
