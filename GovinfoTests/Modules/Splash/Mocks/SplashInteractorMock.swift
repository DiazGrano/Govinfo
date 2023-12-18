//
//  SplashInteractorMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

@testable import Govinfo
import XCTest

class SplashInteractorMock: SplashInteractorProtocol {
    var expectGetFacts: XCTestExpectation?
    
    func getFacts() {
        expectGetFacts?.fulfill()
    }
}
