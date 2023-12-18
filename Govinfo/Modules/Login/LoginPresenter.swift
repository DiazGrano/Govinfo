//
//  LoginPresenter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class LoginPresenter {
    private weak var view: LoginViewControllerProtocol?
    private let interactor: LoginInteractorProtocol
    private let router: LoginRouterProtocol
    private let facts: GovFactsResponse
    
    init(interactor: LoginInteractorProtocol, router: LoginRouterProtocol, facts: GovFactsResponse) {
        self.interactor = interactor
        self.router = router
        self.facts = facts
    }
    
    func setView(_ view: LoginViewControllerProtocol) {
        self.view = view
    }
}

extension LoginPresenter: LoginPresenterProtocol {
    func fetchUserLogIn(model: LoginRequest, useBiometrics: Bool) {
        NetworkConnectionChecker().checkReachability { [unowned self] enabled in
            guard enabled else {
                self.view?.showError(error: ErrorResponse.getDefaultError(type: .noInternet))
                return
            }
            self.interactor.getUserLogIn(model: model, useBiometrics: useBiometrics)
        }
    }
    
    func fetchUserRegistration(model: LoginRequest, useBiometrics: Bool) {
        NetworkConnectionChecker().checkReachability { [unowned self] enabled in
            guard enabled else {
                self.view?.showError(error: ErrorResponse.getDefaultError(type: .noInternet))
                return
            }
            self.interactor.getUserRegistration(model: model, useBiometrics: useBiometrics)
        }
    }
    
    func fetchGoogleLogIn(controller: UIViewController, useBiometrics: Bool) {
        NetworkConnectionChecker().checkReachability { [unowned self] enabled in
            guard enabled else {
                self.view?.showError(error: ErrorResponse.getDefaultError(type: .noInternet))
                return
            }
            self.interactor.getGoogleLogIn(controller: controller, useBiometrics: useBiometrics)
        }
    }
    
    func fetchBiometricsLogIn() {
        NetworkConnectionChecker().checkReachability { [unowned self] enabled in
            guard enabled else {
                self.view?.showError(error: ErrorResponse.getDefaultError(type: .noInternet))
                return
            }
            self.interactor.getBiometricsLogIn()
        }
    }
    
    func fetchedLogIn() {
        view?.showSuccessLogIn()
        router.goToDataTables(facts: facts)
    }
    
    func fetchedError(error: ErrorResponse) {
        view?.showError(error: error)
    }
    
    func fetchBiometricsPermission() {
        interactor.getBiometricsPermission()
    }
    
    func fetchedBiometricsPermission(authenticated: Bool) {
        view?.showBiometricsPermission(authenticated: authenticated)
    }
}
