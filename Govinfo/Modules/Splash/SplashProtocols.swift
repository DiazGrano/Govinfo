//
//  SplashProtocols.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

protocol SplashViewControllerProtocol: AnyObject {
    func showSuccess()
    func showError(error: ErrorResponse)
}

protocol SplashViewUIProtocol: AnyObject {
    
}

protocol SplashInteractorProtocol: AnyObject {
    func getFacts()
}

protocol SplashPresenterProtocol: AnyObject {
    func fetchFacts()
    func fetchedFacts(model: GovFactsResponse)
    func fetchedError(error: ErrorResponse)
    func goToLoginScreen()
}

protocol SplashRouterProtocol: AnyObject {
    func goToLogin(facts: GovFactsResponse)
}
