//
//  SplashViewControllerMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class LoginViewControllerMock: LoginViewControllerProtocol, LoginViewUIProtocol {
    var expectShowError: XCTestExpectation?
    var expectShowErrorNoInternet: XCTestExpectation?
    var expectShowSuccessLogIn: XCTestExpectation?
    var expectShowBiometricsPermission: XCTestExpectation?
    var expectLogInWithGoogle: XCTestExpectation?
    var expectLogInWithUserAndPass: XCTestExpectation?
    var expectRegisterUser: XCTestExpectation?
    var expectLogInWithBiometrics: XCTestExpectation?
    var expectCheckBiometricsPermission: XCTestExpectation?
    
    func showError(error: ErrorResponse) {
        if error.defaultErrorType == .noInternet {
            expectShowErrorNoInternet?.fulfill()
        } else {
            expectShowError?.fulfill()
        }
    }
    
    func showSuccessLogIn() {
        expectShowSuccessLogIn?.fulfill()
    }
    
    func showBiometricsPermission(authenticated: Bool) {
        expectShowBiometricsPermission?.fulfill()
    }
    
    func logInWithGoogle(useBiometrics: Bool) {
        expectLogInWithGoogle?.fulfill()
    }
    
    func logInWithUserAndPass(model: LoginRequest, useBiometrics: Bool) {
        expectLogInWithUserAndPass?.fulfill()
    }
    
    func registerUser(model: LoginRequest, useBiometrics: Bool) {
        expectRegisterUser?.fulfill()
    }
    
    func logInWithBiometrics() {
        expectLogInWithBiometrics?.fulfill()
    }
    
    func checkBiometricsPermission() {
        expectCheckBiometricsPermission?.fulfill()
    }
}
