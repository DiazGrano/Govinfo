//
//  SplashInteractorTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import XCTest
@testable import Govinfo

final class SplashInteractorTests: XCTestCase {
    var sut: SplashInteractor!
    var presenterMock: SplashPresenterMock!
    
    override func setUpWithError() throws {
        sut = SplashInteractor()
        presenterMock = SplashPresenterMock()
        sut.setPresenter(presenterMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }

    func testGetFacts() {
        sut.networkManager = NetworkManagerMock(successModel: GovFactsResponse())
        let expect = expectation(description: "Test get facts")
        presenterMock.expectFetchedFacts = expect
        sut.getFacts()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetFactsError() {
        sut.networkManager = NetworkManagerMock(isSuccess: false)
        let expect = expectation(description: "Test get facts error")
        presenterMock.expectFetchedError = expect
        sut.getFacts()
        wait(for: [expect], timeout: 1)
    }
}
