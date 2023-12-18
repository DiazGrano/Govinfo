//
//  CatalogViewControllerMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class CatalogViewControllerMock: CatalogViewControllerProtocol, CatalogViewUIProtocol {
    var expectGetFactsModel: XCTestExpectation?
    var expectSetFactsFilter: XCTestExpectation?
    var expectShowDetails: XCTestExpectation?
    var factsModel = [Fact()]
    
    func getFactsModel() -> [Fact] {
        expectGetFactsModel?.fulfill()
        return factsModel
    }
    
    func setFactsFilter(name: String) {
        expectSetFactsFilter?.fulfill()
    }
    
    func showDetails(fact: Fact) {
        expectShowDetails?.fulfill()
    }
}
