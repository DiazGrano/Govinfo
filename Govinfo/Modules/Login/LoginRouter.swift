//
//  LoginRouter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class LoginRouter {
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start(facts: GovFactsResponse) {
        let interactor = LoginInteractor()
        let presenter = LoginPresenter(interactor: interactor, router: self, facts: facts)
        let view = LoginViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        push(view)
    }
    
    private func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.pushViewController(viewController, animated: animated)
    }
}

extension LoginRouter: LoginRouterProtocol {
    func goToDataTables(facts: GovFactsResponse) {
        CatalogRouter(navigation: navigation).start(facts: facts)
    }
}
