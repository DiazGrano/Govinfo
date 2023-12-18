//
//  CatalogProtocols.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import Foundation

protocol CatalogViewControllerProtocol: AnyObject {
    
}

protocol CatalogViewUIProtocol: AnyObject {
    func getFactsModel() -> [Fact]
    func setFactsFilter(name: String)
    func showDetails(fact: Fact)
}

protocol CatalogInteractorProtocol: AnyObject {
    
}

protocol CatalogPresenterProtocol: AnyObject {
    func fetchFacts() -> [Fact]
    func setFactsFilter(name: String)
    func fetchFactDetails(fact: Fact)
}

protocol CatalogRouterProtocol: AnyObject {
    func goToFactDetails(fact: Fact)
}
