//
//  DetailsViewController.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import UIKit

class DetailsViewController: GovinfoViewController {
    private let presenter: DetailsPresenterProtocol
    private var ui: DetailsViewUI?
    
    required init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        title = "Details.title".localized
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        ui = DetailsViewUI(delegate: self)
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchDetails()
    }
}

extension DetailsViewController: DetailsViewControllerProtocol {
    func showDetails(elements: [GovinfoLabelViewUI]) {
        ui?.loadDetails(elements: elements)
    }
    
    func showError(error: ErrorResponse) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: error.title, message: error.getFullMessage(), preferredStyle: .alert)
            let action = UIAlertAction(title: "Alerts.action.ok".localized, style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}

extension DetailsViewController: DetailsViewUIProtocol {
    func shareDetailsToWhatsApp() {
        presenter.sendDetailsToWhatsApp()
    }
}
