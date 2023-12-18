//
//  SplashPresenterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class LoginPresenterMock: LoginPresenterProtocol  {
    var expectFetchUserLogIn: XCTestExpectation?
    var expectFetchUserRegistration: XCTestExpectation?
    var expectFetchGoogleLogIn: XCTestExpectation?
    var expectFetchBiometricsLogIn: XCTestExpectation?
    var expectFetchedLogIn: XCTestExpectation?
    var expectFetchedError: XCTestExpectation?
    var expectFetchedErrorBiometric: XCTestExpectation?
    var expectFetchBiometricsPermission: XCTestExpectation?
    var expectFetchedBiometricsPermissionTrue: XCTestExpectation?
    var expectFetchedBiometricsPermissionFalse: XCTestExpectation?
    
    func fetchUserLogIn(model: LoginRequest, useBiometrics: Bool) {
        expectFetchUserLogIn?.fulfill()
    }
    
    func fetchUserRegistration(model: LoginRequest, useBiometrics: Bool) {
        expectFetchUserRegistration?.fulfill()
    }
    
    func fetchGoogleLogIn(controller: UIViewController, useBiometrics: Bool) {
        expectFetchGoogleLogIn?.fulfill()
    }
    
    func fetchBiometricsLogIn() {
        expectFetchBiometricsLogIn?.fulfill()
    }
    
    func fetchedLogIn() {
        expectFetchedLogIn?.fulfill()
    }
    
    func fetchedError(error: ErrorResponse) {
        if error.defaultErrorType == .biometric {
            expectFetchedErrorBiometric?.fulfill()
        } else {
            expectFetchedError?.fulfill()
        }
    }
    
    func fetchBiometricsPermission() {
        expectFetchBiometricsPermission?.fulfill()
    }
    
    func fetchedBiometricsPermission(authenticated: Bool) {
        if authenticated {
            expectFetchedBiometricsPermissionTrue?.fulfill()
        } else {
            expectFetchedBiometricsPermissionFalse?.fulfill()
        }
    }
}
