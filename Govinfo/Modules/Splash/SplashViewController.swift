//
//  SplashViewController.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class SplashViewController: GovinfoViewController {
    private let presenter: SplashPresenterProtocol
    private var ui: SplashViewUI?
    
    required init(presenter: SplashPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        ui = SplashViewUI(delegate: self)
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader(message: "Splash.loadingMessage".localized)
        presenter.fetchFacts()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func showSuccess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.hideLoader { [unowned self] in
                self.presenter.goToLoginScreen()
            }
        }
    }
    
    func showError(error: ErrorResponse) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: error.title, message: error.getFullMessage(), preferredStyle: .alert)
            let action = UIAlertAction(title: "Alerts.action.retry".localized, style: .default) { [unowned self] _ in
                self.presenter.fetchFacts()
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
}

extension SplashViewController: SplashViewUIProtocol {
    
}
