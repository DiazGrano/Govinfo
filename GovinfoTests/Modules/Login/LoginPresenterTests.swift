//
//  SplashPresenterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class LoginPresenterTests: XCTestCase {
    var sut: LoginPresenter!
    var interactorMock: LoginInteractorMock!
    var routerMock: LoginRouterMock!
    var viewMock: LoginViewControllerMock!
    var networkChecker: NetworkConnectionChecker!
    
    override func setUpWithError() throws {
        interactorMock = LoginInteractorMock()
        routerMock = LoginRouterMock()
        viewMock = LoginViewControllerMock()
        networkChecker = NetworkConnectionChecker()
        networkChecker.networkManager = NetworkManagerMock()
        sut = LoginPresenter(interactor: interactorMock, router: routerMock, facts: GovFactsResponse())
        sut.networkChecker = networkChecker
        sut.setView(viewMock)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactorMock = nil
        routerMock = nil
        viewMock = nil
        networkChecker = nil
    }
    
    func testFetchUserLogIn() {
        let expect = expectation(description: "Test fetch user login")
        interactorMock.expectGetUserLogIn = expect
        sut.fetchUserLogIn(model: LoginRequest(user: "", pass: ""), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserLogInError() {
        networkChecker.networkManager = NetworkManagerMock(isSuccess: false)
        let expect = expectation(description: "Test fetch user login error")
        viewMock.expectShowErrorNoInternet = expect
        sut.fetchUserLogIn(model: LoginRequest(user: "", pass: ""), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserRegistration() {
        let expect = expectation(description: "Test fetch registration")
        interactorMock.expectGetUserRegistration = expect
        sut.fetchUserRegistration(model: LoginRequest(user: "", pass: ""), useBiometrics: false)
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserRegistrationError() {
        networkChecker.networkManager = NetworkManagerMock(isSuccess: false)
        let expect = expectation(description: "Test fetch user registration error")
        viewMock.expectShowErrorNoInternet = expect
        sut.fetchUserRegistration(model: LoginRequest(user: "", pass: ""), useBiometrics: false)
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserGoogleLogIn() {
        let expect = expectation(description: "Test fetch google login")
        interactorMock.expectGetGoogleLogIn = expect
        sut.fetchGoogleLogIn(controller: UIViewController(), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserGoogleLogInError() {
        networkChecker.networkManager = NetworkManagerMock(isSuccess: false)
        let expect = expectation(description: "Test fetch user google login error")
        viewMock.expectShowErrorNoInternet = expect
        sut.fetchGoogleLogIn(controller: UIViewController(), useBiometrics: false)
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserBiometricLogIn() {
        let expect = expectation(description: "Test fetch biometric login")
        interactorMock.expectGetBiometricsLogIn = expect
        sut.fetchBiometricsLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchUserBiometricLogInError() {
        networkChecker.networkManager = NetworkManagerMock(isSuccess: false)
        let expect = expectation(description: "Test fetch user biometric login error")
        viewMock.expectShowErrorNoInternet = expect
        sut.fetchBiometricsLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchedLogIn() {
        let expect = expectation(description: "Test fetched logIn")
        routerMock.expectGoToDataTables = expect
        sut.fetchedLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchedError() {
        let expect = expectation(description: "Test fetched error")
        viewMock.expectShowError = expect
        sut.fetchedError(error: .getDefaultError(type: .unknown))
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchBiometricsPermission() {
        let expect = expectation(description: "Test fetch biometrics permission")
        interactorMock.expectGetBiometricsPermission = expect
        sut.fetchBiometricsPermission()
        wait(for: [expect], timeout: 1)
    }
    
    func testFetchedBiometricsPermission() {
        let expect = expectation(description: "Test fetched biometrics permission")
        viewMock.expectShowBiometricsPermission = expect
        sut.fetchedBiometricsPermission(authenticated: true)
        wait(for: [expect], timeout: 1)
    }
}
