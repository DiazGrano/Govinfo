//
//  FactsViewCellUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 110/12/23.
//

import UIKit

internal protocol CatalogViewCellProtocol: AnyObject {
    func catalogViewCellTapped(data: Fact)
}

class CatalogViewCell: UITableViewCell {
    static let identifier = "CatalogViewCell"
    static let rowHeight: CGFloat = 140
    private var cellData: Fact = Fact()
    weak var delegate: CatalogViewCellProtocol?
    private var containerCenterXConstraint = NSLayoutConstraint()
    private let separation = UIScreen.main.bounds.width
    
    lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBorder()
        view.addGradient()
        return view
    }()
    
    private lazy var factLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .getComicFont(16)
        label.textColor = .govinfoBlack
        return label
    }()
    
    private lazy var sourceLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .getComicFont(12)
        label.textColor = .govinfoGrayDarkest
        label.textAlignment = .right
        return label
    }()
    
    private lazy var organizationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .getComicFont(12)
        label.textColor = .govinfoGrayDarkest
        label.textAlignment = .right
        return label
    }()
    
   
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initComponents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CatalogViewCell {
    private func initComponents() {
        backgroundColor = .clear
        selectionStyle = .none
        setSubviews()
        setAutolayout()
        setTargets()
    }
    
    private func setSubviews() {
        contentView.addSubview(mainContainerView)
        
        mainContainerView.addSubview(contentContainer)
        
        contentContainer.addSubview(factLabel)
        contentContainer.addSubview(sourceLabel)
        contentContainer.addSubview(organizationLabel)
    }
    
    private func setAutolayout() {
        containerCenterXConstraint = contentContainer.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor, constant: separation)
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentContainer.topAnchor.constraint(equalTo: mainContainerView.topAnchor, constant: 5),
            containerCenterXConstraint,
            contentContainer.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: -5),
            contentContainer.widthAnchor.constraint(equalTo: mainContainerView.widthAnchor, constant: -40),
            
            factLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 10),
            factLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 10),
            factLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -10),
            
            sourceLabel.topAnchor.constraint(greaterThanOrEqualTo: factLabel.bottomAnchor),
            sourceLabel.leadingAnchor.constraint(equalTo: factLabel.leadingAnchor),
            sourceLabel.trailingAnchor.constraint(equalTo: factLabel.trailingAnchor),
            sourceLabel.bottomAnchor.constraint(equalTo: organizationLabel.topAnchor),
            
            organizationLabel.leadingAnchor.constraint(equalTo: factLabel.leadingAnchor),
            organizationLabel.trailingAnchor.constraint(equalTo: factLabel.trailingAnchor),
            organizationLabel.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: -10)
        ])
    }
    
    private func setTargets() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped))
        gesture.numberOfTapsRequired = 1
        mainContainerView.addGestureRecognizer(gesture)
    }
    
    @objc private func cellTapped() {
        delegate?.catalogViewCellTapped(data: cellData)
    }
    
    func setCell(cellData: Fact) {
        containerCenterXConstraint.constant = separation
        layoutIfNeeded()
        self.cellData = cellData
        factLabel.text = cellData.fact
        sourceLabel.text = cellData.resource
        organizationLabel.text = cellData.organization
        animateAppearing()
    }
    
    private func animateAppearing() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.containerCenterXConstraint.constant = 0
                self.layoutIfNeeded()
            }
        }
    }
}
