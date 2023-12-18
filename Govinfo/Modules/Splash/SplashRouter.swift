//
//  SplashRouter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class SplashRouter {
    private(set) var navigation: UINavigationController?
    
    public func start() -> UIViewController {
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(interactor: interactor, router: self)
        let view = SplashViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        return view
    }
    
    func setNavigation(_ navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension SplashRouter: SplashRouterProtocol {
    func goToLogin(facts: GovFactsResponse) {
        guard let notNilNav = navigation else {
            return
        }
        
        LoginRouter(navigation: notNilNav).start(facts: facts)
    }
}
