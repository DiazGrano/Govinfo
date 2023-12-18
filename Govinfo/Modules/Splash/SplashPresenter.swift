//
//  SplashPresenter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

class SplashPresenter {
    private weak var view: SplashViewControllerProtocol?
    private let interactor: SplashInteractorProtocol
    private let router: SplashRouterProtocol
    private var facts: GovFactsResponse = GovFactsResponse()
    var networkChecker = NetworkConnectionChecker()
    var locationManager = LocationHelper()
    
    init(interactor: SplashInteractorProtocol, router: SplashRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func setView(_ view: SplashViewControllerProtocol) {
        self.view = view
    }
}

extension SplashPresenter: SplashPresenterProtocol {
    func fetchFacts() {
        networkChecker.checkReachability { [unowned self] enabled in
            guard enabled else {
                self.view?.showError(error: ErrorResponse.getDefaultError(type: .noInternet))
                return
            }
            locationManager.requestLocationPermission()
            self.interactor.getFacts()
        }
    }
    
    func fetchedFacts(model: GovFactsResponse) {
        facts = model
        view?.showSuccess()
    }
    
    func fetchedError(error: ErrorResponse) {
        view?.showError(error: error)
    }
    
    func goToLoginScreen() {
        router.goToLogin(facts: facts)
    }
}
