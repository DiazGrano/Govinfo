//
//  SplashPresenterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

@testable import Govinfo
import XCTest

class SplashPresenterMock: SplashPresenterProtocol {
    var expectFetchFacts: XCTestExpectation?
    var expectFetchedFacts: XCTestExpectation?
    var expectFetchedError: XCTestExpectation?
    var expectGoToLoginScreen: XCTestExpectation?
    
    func fetchFacts() {
        expectFetchFacts?.fulfill()
    }
    
    func fetchedFacts(model: Govinfo.GovFactsResponse) {
        expectFetchedFacts?.fulfill()
    }
    
    func fetchedError(error: Govinfo.ErrorResponse) {
        expectFetchedError?.fulfill()
    }
    
    func goToLoginScreen() {
        expectGoToLoginScreen?.fulfill()
    }
}
