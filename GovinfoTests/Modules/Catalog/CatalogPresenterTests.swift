//
//  CatalogPresenterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class CatalogPresenterTests: XCTestCase {
    var sut: CatalogPresenter!
    var interactorMock: CatalogInteractorMock!
    var routerMock: CatalogRouterMock!
    var viewMock: CatalogViewControllerMock!
    var model: GovFactsResponse!
    
    override func setUpWithError() throws {
        interactorMock = CatalogInteractorMock()
        routerMock = CatalogRouterMock()
        viewMock = CatalogViewControllerMock()
        model = GovFactsResponse(facts: [Fact(organization: "SEDENA"), Fact(organization: "SALUD")])
        sut = CatalogPresenter(interactor: interactorMock, router: routerMock, facts: model)
        sut.setView(viewMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactorMock = nil
        routerMock = nil
        viewMock = nil
        model = nil
    }
    
    func testFetchFacts() {
        XCTAssertEqual(sut.fetchFacts().count, model.facts.count)
    }
    
    func testSetFactsFilter() {
        let filter = "SEDENA"
        sut.setFactsFilter(name: filter)
        let filteredModel = model.facts.filter({ $0.organization.uppercased().contains(filter.uppercased()) })
        
        XCTAssertEqual(sut.fetchFacts().count, filteredModel.count)
    }
    
    func testSetFactsFilterEmpty() {
        sut.setFactsFilter(name: "")
        XCTAssertEqual(sut.fetchFacts().count, model.facts.count)
    }
    
    func testFetchFactDetails() {
        let expect = expectation(description: "Test fetch fact details")
        routerMock.expectGoToFactDetails = expect
        sut.fetchFactDetails(fact: Fact())
        wait(for: [expect], timeout: 1)
    }
}
