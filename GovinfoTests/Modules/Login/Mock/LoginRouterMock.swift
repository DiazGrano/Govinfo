//
//  SplasRouterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class LoginRouterMock: LoginRouterProtocol {
    var expectGoToDataTables: XCTestExpectation?
    
    func goToDataTables(facts: GovFactsResponse) {
        expectGoToDataTables?.fulfill()
    }
}
