//
//  SplasRouterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

@testable import Govinfo
import XCTest

class SplasRouterMock: SplashRouterProtocol {
    var expectGoToLogin: XCTestExpectation?
    
    func goToLogin(facts: GovFactsResponse) {
        expectGoToLogin?.fulfill()
    }
}
