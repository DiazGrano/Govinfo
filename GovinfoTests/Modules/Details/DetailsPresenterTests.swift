//
//  DetailsPresenterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class DetailsPresenterTests: XCTestCase {
    var sut: DetailsPresenter!
    var interactorMock: DetailsInteractorMock!
    var routerMock: DetailsRouterMock!
    var viewMock: DetailsViewControllerMock!
    var locationHelperMock: LocationHelperMock!
    var urlOpenerHelperMock: URLOpenerHelperMock!
    var fact: Fact!
    
    
    override func setUpWithError() throws {
        interactorMock = DetailsInteractorMock()
        routerMock = DetailsRouterMock()
        viewMock = DetailsViewControllerMock()
        fact = Fact(organization: "SEDENA")
        sut = DetailsPresenter(interactor: interactorMock, router: routerMock, fact: fact)
        sut.setView(viewMock)
        locationHelperMock = LocationHelperMock()
        sut.locationHelper = locationHelperMock
        urlOpenerHelperMock = URLOpenerHelperMock()
        sut.urlOpenerHelper = urlOpenerHelperMock
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactorMock = nil
        routerMock = nil
        viewMock = nil
        fact = nil
        locationHelperMock = nil
        urlOpenerHelperMock = nil
    }
    
    func testSendDetailsToWhatsApp() {
        XCTAssertNotNil(sut.sendDetailsToWhatsApp())
    }
    
    func testSendDetailsToWhatsAppLocationError() {
        locationHelperMock.isAvailable = false
        XCTAssertNotNil(sut.sendDetailsToWhatsApp())
    }
    
    func testSendDetailsToWhatsAppError() {
        urlOpenerHelperMock.canOpen = false
        let expect = expectation(description: "Test send details to whatsapp error")
        viewMock.expectShowErrorWhatsApp = expect
        sut.sendDetailsToWhatsApp()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchDetails() {
        let expect = expectation(description: "Test fetch details")
        viewMock.expectShowDetails = expect
        sut.fetchDetails()
        wait(for: [expect], timeout: 1)
    }
}
