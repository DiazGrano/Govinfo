//
//  DetailsRouter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 15/12/23.
//

import UIKit

class DetailsRouter {
    private let navigation: UINavigationController
    private let fact: Fact
    
    public init(navigation: UINavigationController, fact: Fact) {
        self.navigation = navigation
        self.fact = fact
    }
    
    public func start() {
        let interactor = DetailsInteractor()
        let presenter = DetailsPresenter(interactor: interactor, router: self, fact: fact)
        let view = DetailsViewController(presenter: presenter)
        
        presenter.setView(view)
        interactor.setPresenter(presenter)
        
        push(view)
    }
    
    private func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigation.pushViewController(viewController, animated: animated)
    }
}

extension DetailsRouter: DetailsRouterProtocol {
    
}
