//
//  CatalogViewUI.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import UIKit

class CatalogViewUI: UIView {
    private weak var delegate: CatalogViewUIProtocol?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchTextfield: GovinfoTextfieldViewUI = {
       let textfield = GovinfoTextfieldViewUI()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.govinfoPlaceholder = "Textfields.search".localized
        textfield.identifier = "Textfields.search".localized
        textfield.govinfoDelegate = self
        textfield.needTextValidation = false
        return textfield
    }()
    
    private lazy var factsTable: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CatalogViewCell.self, forCellReuseIdentifier: CatalogViewCell.identifier)
        table.rowHeight = CatalogViewCell.rowHeight
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.contentInset.top = 55
        table.contentInset.bottom = 40
        table.contentOffset.y = -table.contentInset.top
        return table
    }()
    
    required init(delegate: CatalogViewUIProtocol) {
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CatalogViewUI {
    func initComponents() {
        setSubviews()
        setAutolayout()
        backgroundColor = .govinfoOrange
        factsTable.reloadData()
    }
    
    func setSubviews(){
        addSubview(containerView)
        containerView.addSubview(factsTable)
        containerView.addSubview(searchTextfield)
    }
    
    func setAutolayout(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchTextfield.topAnchor.constraint(equalTo: containerView.topAnchor),
            searchTextfield.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            searchTextfield.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            searchTextfield.heightAnchor.constraint(equalToConstant: 50),
            
            factsTable.topAnchor.constraint(equalTo: searchTextfield.topAnchor, constant: 10),
            factsTable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            factsTable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            factsTable.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}

extension CatalogViewUI: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = delegate?.getFactsModel(), !model.isEmpty else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: CatalogViewCell.identifier, for: indexPath) as? CatalogViewCell
        
        guard let nonNilCell = cell else {
            return UITableViewCell()
        }
        nonNilCell.setCell(cellData: model[indexPath.row])
        nonNilCell.delegate = self

        return nonNilCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = delegate?.getFactsModel() else {
            return 0
        }
        return model.count
    }
}

extension CatalogViewUI: CatalogViewCellProtocol {
    func catalogViewCellTapped(data: Fact) {
        delegate?.showDetails(fact: data)
    }
}

extension CatalogViewUI: GovinfoTextfieldViewUIDelegate {
    func govinfoTextfieldViewUITextChanged(textField: GovinfoTextfieldViewUI) {
        delegate?.setFactsFilter(name: textField.getText())
        factsTable.reloadData()
    }
    
    func govinfoTextfieldViewUIDone(textField: GovinfoTextfieldViewUI) {
        textField.resignFirstResponder()
    }
}


