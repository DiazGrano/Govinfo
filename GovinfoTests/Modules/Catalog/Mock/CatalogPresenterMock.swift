//
//  CatalogPresenterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class CatalogPresenterMock: CatalogPresenterProtocol  {
    var expectFetchFacts: XCTestExpectation?
    var expectSetFactsFilter: XCTestExpectation?
    var expectFetchFactDetails: XCTestExpectation?
    
    func fetchFacts() -> [Fact] {
        expectFetchFacts?.fulfill()
        return [Fact()]
    }
    
    func setFactsFilter(name: String) {
        expectSetFactsFilter?.fulfill()
    }
    
    func fetchFactDetails(fact: Fact) {
        expectFetchFactDetails?.fulfill()
    }
}
