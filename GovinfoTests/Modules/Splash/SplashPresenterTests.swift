//
//  SplashPresenterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import XCTest
@testable import Govinfo

final class SplashPresenterTests: XCTestCase {
    var sut: SplashPresenter!
    var interactorMock: SplashInteractorMock!
    var routerMock: SplasRouterMock!
    var viewMock: SplashViewControllerMock!
    var networkChecker: NetworkConnectionChecker!

    override func setUpWithError() throws {
        interactorMock = SplashInteractorMock()
        routerMock = SplasRouterMock()
        viewMock = SplashViewControllerMock()
        networkChecker = NetworkConnectionChecker()
        networkChecker.networkManager = NetworkManagerMock()
        sut = SplashPresenter(interactor: interactorMock, router: routerMock)
        sut.networkChecker = networkChecker
        sut.setView(viewMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        interactorMock = nil
        routerMock = nil
        viewMock = nil
        networkChecker = nil
    }
    
    func testFetchFacts() {
        let expect = XCTestExpectation(description: "Test fetch facts")
        interactorMock.expectGetFacts = expect
        sut.fetchFacts()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchFactsNoInternetError() {
        networkChecker.networkManager = NetworkManagerMock(isSuccess: false)
        let expect = XCTestExpectation(description: "Test fetch facts no internet error")
        viewMock.expectShowErrorNoInternet = expect
        sut.fetchFacts()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchedFacts() {
        let expect = XCTestExpectation(description: "Test fetched facts")
        viewMock.expectShowSuccess = expect
        sut.fetchedFacts(model: GovFactsResponse())
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchedError() {
        let expect = XCTestExpectation(description: "Test fetched error")
        viewMock.expectShowError = expect
        sut.fetchedError(error: ErrorResponse())
        wait(for: [expect], timeout: 1)
    }
    
    func testGoToLoginScreen() {
        let expect = XCTestExpectation(description: "Test go to login screen")
        routerMock.expectGoToLogin = expect
        sut.goToLoginScreen()
        wait(for: [expect], timeout: 1)
    }
}
