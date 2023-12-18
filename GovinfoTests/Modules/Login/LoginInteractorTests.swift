//
//  SplashInteractorTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class LoginInteractorTests: XCTestCase {
    var sut: LoginInteractor!
    var presenterMock: LoginPresenterMock!
    var firebaseHelperMock: FirebaseHelperMock!
    var biometricHelperMock: BiometricHelperMock!
    
    override func setUpWithError() throws {
        sut = LoginInteractor()
        firebaseHelperMock = FirebaseHelperMock()
        sut.firebaseHelper = firebaseHelperMock
        presenterMock = LoginPresenterMock()
        sut.setPresenter(presenterMock)
        biometricHelperMock = BiometricHelperMock()
        sut.biometricHelper = biometricHelperMock
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
        firebaseHelperMock = nil
    }
    
    func testGetUserLogIn() {
        let expect = expectation(description: "Test get user log in")
        presenterMock.expectFetchedLogIn = expect
        sut.getUserLogIn(model: LoginRequest(user: "", pass: ""), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testGetUserLogInError() {
        firebaseHelperMock.isSuccess = false
        let expect = expectation(description: "Test get user log in error")
        presenterMock.expectFetchedError = expect
        sut.getUserLogIn(model: LoginRequest(user: "", pass: ""), useBiometrics: false)
        wait(for: [expect], timeout: 1)
    }
    
    func testGetUserRegistration() {
        let expect = expectation(description: "Test get user registration")
        presenterMock.expectFetchedLogIn = expect
        sut.getUserRegistration(model: LoginRequest(user: "", pass: ""), useBiometrics: false)
        wait(for: [expect], timeout: 1)
    }
    
    func testGetUserRegistrationError() {
        firebaseHelperMock.isSuccess = false
        let expect = expectation(description: "Test get user registration error")
        presenterMock.expectFetchedError = expect
        sut.getUserRegistration(model: LoginRequest(user: "", pass: ""), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testGetGoogleLogIn() {
        let expect = expectation(description: "Test get google login")
        presenterMock.expectFetchedLogIn = expect
        sut.getGoogleLogIn(controller: UIViewController(), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testGetGoogleLogInError() {
        firebaseHelperMock.isSuccess = false
        let expect = expectation(description: "Test get google login error")
        presenterMock.expectFetchedError = expect
        sut.getGoogleLogIn(controller: UIViewController(), useBiometrics: false)
        wait(for: [expect], timeout: 1)
    }
    
    
    
    func testLoginWithGoogle() {
        let expect = expectation(description: "Test google login")
        presenterMock.expectFetchedLogIn = expect
        sut.loginWithGoogle(useBiometrics: false, idToken: "", accessToken: "")
        wait(for: [expect], timeout: 1)
    }
    
    func testLoginWithGoogleError() {
        firebaseHelperMock.isSuccess = false
        let expect = expectation(description: "Test google login error")
        presenterMock.expectFetchedError = expect
        sut.loginWithGoogle(useBiometrics: true, idToken: "", accessToken: "")
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricsLogInGoogle() {
        let expect = expectation(description: "Test get biometrics login google")
        presenterMock.expectFetchedLogIn = expect
        UserDefaults.standard.set(true, forKey: LoginKeys.biometrics)
        UserDefaults.standard.set(true, forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.set("", forKey: LoginKeys.idToken)
        UserDefaults.standard.set("", forKey: LoginKeys.accessToken)
        sut.getBiometricsLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricsLogInGoogleError() {
        let expect = expectation(description: "Test get biometrics login google error")
        presenterMock.expectFetchedError = expect
        UserDefaults.standard.set(true, forKey: LoginKeys.biometrics)
        UserDefaults.standard.set(true, forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.removeObject(forKey: LoginKeys.idToken)
        UserDefaults.standard.removeObject(forKey: LoginKeys.accessToken)
        sut.getBiometricsLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricsLogInUser() {
        let expect = expectation(description: "Test get biometrics login user")
        presenterMock.expectFetchedLogIn = expect
        UserDefaults.standard.set(true, forKey: LoginKeys.biometrics)
        UserDefaults.standard.set(false, forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.set("", forKey: LoginKeys.user)
        UserDefaults.standard.set("", forKey: LoginKeys.pass)
        sut.getBiometricsLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricsLogInUserError() {
        let expect = expectation(description: "Test get biometrics login user")
        presenterMock.expectFetchedError = expect
        UserDefaults.standard.set(true, forKey: LoginKeys.biometrics)
        UserDefaults.standard.set(false, forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.removeObject(forKey: LoginKeys.user)
        UserDefaults.standard.removeObject(forKey: LoginKeys.pass)
        sut.getBiometricsLogIn()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricPermission() {
        let expect = expectation(description: "Test get biometric permission")
        presenterMock.expectFetchedBiometricsPermissionTrue = expect
        sut.getBiometricsPermission()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricPermissionError() {
        biometricHelperMock.isSuccess = false
        let expect = expectation(description: "Test get biometric permission error")
        presenterMock.expectFetchedBiometricsPermissionFalse = expect
        sut.getBiometricsPermission()
        wait(for: [expect], timeout: 1)
    }
    
    func testGetBiometricPermissionNotAvailable() {
        biometricHelperMock.isAvailable = false
        let expect = expectation(description: "Test get biometric permission not available")
        presenterMock.expectFetchedErrorBiometric = expect
        sut.getBiometricsPermission()
        wait(for: [expect], timeout: 1)
    }
}
