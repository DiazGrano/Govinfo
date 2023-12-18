//
//  GovinfoSeparatorViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import UIKit

class GovinfoSeparatorViewUI: UIView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    private lazy var leftLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.govinfoBlack
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .getComicFont(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .govinfoBlack
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var rightLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.govinfoBlack
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

extension GovinfoSeparatorViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
    }
    
    func setSubviews() {
        addSubview(leftLineView)
        addSubview(titleLabel)
        addSubview(rightLineView)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            leftLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLineView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
            leftLineView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            leftLineView.heightAnchor.constraint(equalToConstant: 2),

            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rightLineView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10),
            rightLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLineView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            rightLineView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
