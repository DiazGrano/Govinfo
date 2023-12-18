//
//  SplashViewMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

@testable import Govinfo
import XCTest

class SplashViewControllerMock: SplashViewControllerProtocol, SplashViewUIProtocol {
    var expectShowSuccess: XCTestExpectation?
    var expectShowError: XCTestExpectation?
    var expectShowErrorNoInternet: XCTestExpectation?
    
    func showSuccess() {
        expectShowSuccess?.fulfill()
    }
    
    func showError(error: ErrorResponse) {
        if error.defaultErrorType == .noInternet {
            expectShowErrorNoInternet?.fulfill()
        } else {
            expectShowError?.fulfill()
        }
    }
}
