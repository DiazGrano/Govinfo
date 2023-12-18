//
//  CatalogRouter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import UIKit

class CatalogRouter {
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    public func start(facts: GovFactsResponse) {
        let interactor = CatalogInteractor()
        let presenter = CatalogPresenter(interactor: interactor, router: self, facts: facts)
        let view = CatalogViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        push(view)
    }
    
    private func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.pushViewController(viewController, animated: animated)
    }
}

extension CatalogRouter: CatalogRouterProtocol {
    func goToFactDetails(fact: Fact) {
        DetailsRouter(navigation: navigation, fact: fact).start()
    }
}
