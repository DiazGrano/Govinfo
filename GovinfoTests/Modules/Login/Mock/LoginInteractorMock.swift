//
//  SplashInteractorMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class LoginInteractorMock: LoginInteractorProtocol {
    var expectGetUserLogIn: XCTestExpectation?
    var expectGetUserRegistration: XCTestExpectation?
    var expectGetGoogleLogIn: XCTestExpectation?
    var expectGetBiometricsLogIn: XCTestExpectation?
    var expectGetBiometricsPermission: XCTestExpectation?
    
    func getUserLogIn(model: LoginRequest, useBiometrics: Bool) {
        expectGetUserLogIn?.fulfill()
    }
    
    func getUserRegistration(model: LoginRequest, useBiometrics: Bool) {
        expectGetUserRegistration?.fulfill()
    }
    
    func getGoogleLogIn(controller: UIViewController, useBiometrics: Bool) {
        expectGetGoogleLogIn?.fulfill()
    }
    
    func getBiometricsLogIn() {
        expectGetBiometricsLogIn?.fulfill()
    }
    
    func getBiometricsPermission() {
        expectGetBiometricsPermission?.fulfill()
    }
}
