//
//  SplashRouter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class SplashRouter {
    private var navigation: UINavigationController?
    
    public func start() -> UIViewController {
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(interactor: interactor, router: self)
        let view = SplashViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        return view
    }
    
    private func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation?.pushViewController(viewController, animated: animated)
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
