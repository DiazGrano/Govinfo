//
//  CatalogPresenter.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import Foundation

class CatalogPresenter {
    private weak var view: CatalogViewControllerProtocol?
    private let interactor: CatalogInteractorProtocol
    private let router: CatalogRouterProtocol
    private let facts: GovFactsResponse
    private var filteredFacts: [Fact] = []
    
    init(interactor: CatalogInteractorProtocol, router: CatalogRouterProtocol, facts: GovFactsResponse) {
        self.interactor = interactor
        self.router = router
        self.facts = facts
        filteredFacts = self.facts.facts
    }
    
    func setView(_ view: CatalogViewControllerProtocol) {
        self.view = view
    }
}

extension CatalogPresenter: CatalogPresenterProtocol {
    func fetchFacts() -> [Fact] {
        return filteredFacts
    }
    
    func setFactsFilter(name: String) {
        guard !name.isEmpty else {
            return filteredFacts = facts.facts
        }
        
        let filteredModel = facts.facts.filter({ $0.organization.uppercased().contains(name.uppercased()) })
        filteredFacts = filteredModel
    }

    func fetchFactDetails(fact: Fact) {
        router.goToFactDetails(fact: fact)
    }
}
