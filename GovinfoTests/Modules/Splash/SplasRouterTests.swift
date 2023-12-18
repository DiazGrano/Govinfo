//
//  SplasRouterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import XCTest
@testable import Govinfo

final class SplasRouterTests: XCTestCase {
    var sut: SplashRouter!
    
    override func setUpWithError() throws {
        sut = SplashRouter()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStart() {
        XCTAssertNotNil(sut.start())
    }
    
    func testSetNavigation() {
        XCTAssertNil(sut.navigation)
        sut.setNavigation(UINavigationController())
        XCTAssertNotNil(sut.navigation)
    }
    
    func testGoToLogin() {
        sut.setNavigation(UINavigationController())
        sut.goToLogin(facts: GovFactsResponse())
        XCTAssertTrue(sut.navigation?.topViewController is LoginViewController)
    }
    
    func testGoToLoginWithNoNav() {
        sut.goToLogin(facts: GovFactsResponse())
        XCTAssertFalse(sut.navigation?.topViewController is LoginViewController)
    }
}
