//
//  GovinfoLabelViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import UIKit

class GovinfoLabelViewUI: UIView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var content: String = "" {
        didSet {
            contentLabel.text = content
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .getComicFont(12)
        label.textColor = .govinfoGrayDarkest
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .getComicFont(16)
        label.textColor = .govinfoBlack
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

extension GovinfoLabelViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
    }
    
    func setSubviews() {
        addSubview(titleLabel)
        addSubview(contentLabel)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentLabel.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
