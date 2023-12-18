//
//  CatalogViewController.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import UIKit

class CatalogViewController: GovinfoViewController {
    private let presenter: CatalogPresenterProtocol
    private var ui: CatalogViewUI?
    
    required init(presenter: CatalogPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Catalog.title".localized
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        ui = CatalogViewUI(delegate: self)
        view = ui
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension CatalogViewController: CatalogViewControllerProtocol {
}

extension CatalogViewController: CatalogViewUIProtocol {
    func getFactsModel() -> [Fact] {
        presenter.fetchFacts()
    }
    
    func setFactsFilter(name: String) {
        presenter.setFactsFilter(name: name)
    }

    func showDetails(fact: Fact) {
        presenter.fetchFactDetails(fact: fact)
    }
}
