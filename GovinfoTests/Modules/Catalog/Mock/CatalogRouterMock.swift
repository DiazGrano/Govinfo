//
//  CatalogRouterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class CatalogRouterMock: CatalogRouterProtocol {
    var expectGoToFactDetails: XCTestExpectation?

    func goToFactDetails(fact: Fact) {
        expectGoToFactDetails?.fulfill()
    }
}
