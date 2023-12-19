//
//  LoginViewController.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit



class LoginViewController: GovinfoViewController {
    private let presenter: LoginPresenterProtocol
    private var ui: LoginViewUI?
    
    required init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func loadView() {
        ui = LoginViewUI(delegate: self)
        view = ui
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        ui?.clearFields()
        let useBiometrics = UserDefaults.standard.bool(forKey: LoginKeys.biometrics)
        ui?.showViewComponents(biometricsSaved: useBiometrics)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func showBiometricsPermission(authenticated: Bool) {
        if !authenticated {
            ui?.setBiometricsCheckStatus(status: authenticated)
        }
    }
    
    func showError(error: ErrorResponse) {
        hideLoader()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: error.title, message: error.getFullMessage(), preferredStyle: .alert)
            let action = UIAlertAction(title: "Alerts.action.ok".localized, style: .default) { [unowned self] _ in
                if error.code == GovinfoConstants.ErrorCodes.biometric {
                    self.ui?.setBiometricsCheckStatus(status: false)
                }
            }
            alert.addAction(action)
            self.present(alert, animated: true)
        }
    }
    
    func showSuccessLogIn() {
        hideLoader()
    }
}

extension LoginViewController: LoginViewUIProtocol {
    func logInWithGoogle(useBiometrics: Bool) {
        showLoader()
        presenter.fetchGoogleLogIn(controller: self, useBiometrics: useBiometrics)
    }
    
    func logInWithUserAndPass(model: LoginRequest, useBiometrics: Bool) {
        showLoader()
        presenter.fetchUserLogIn(model: model, useBiometrics: useBiometrics)
    }
    
    func registerUser(model: LoginRequest, useBiometrics: Bool) {
        showLoader()
        presenter.fetchUserRegistration(model: model, useBiometrics: useBiometrics)
    }
    
    func logInWithBiometrics() {
        showLoader()
        presenter.fetchBiometricsLogIn()
    }
    
    func checkBiometricsPermission() {
        presenter.fetchBiometricsPermission()
    }
}
