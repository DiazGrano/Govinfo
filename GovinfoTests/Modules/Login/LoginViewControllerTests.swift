//
//  LoginViewControllerTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class LoginViewControllerTests: XCTestCase {
    var sut: LoginViewController!
    var presenterMock: LoginPresenterMock!
    
    override func setUpWithError() throws {
        presenterMock = LoginPresenterMock()
        sut = LoginViewController(presenter: presenterMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(LoginViewController(coder: NSCoder()))
    }
    
    func testLogInWithGoogle() {
        let expect = expectation(description: "Test login with google")
        presenterMock.expectFetchGoogleLogIn = expect
        sut.logInWithGoogle(useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testLogInWithUserAndPass() {
        let expect = expectation(description: "Test login with user and pass")
        presenterMock.expectFetchUserLogIn = expect
        sut.logInWithUserAndPass(model: LoginRequest(user: "", pass: ""), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testRegisterUser() {
        let expect = expectation(description: "Test register user")
        presenterMock.expectFetchUserRegistration = expect
        sut.registerUser(model: LoginRequest(user: "", pass: ""), useBiometrics: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testLogInWithBiometrics() {
        let expect = expectation(description: "Test login with biometrics")
        presenterMock.expectFetchBiometricsLogIn = expect
        sut.logInWithBiometrics()
        wait(for: [expect], timeout: 1)
    }
    
    func testCheckBiometricsPermission() {
        let expect = expectation(description: "Test check biometrics permission")
        presenterMock.expectFetchBiometricsPermission = expect
        sut.checkBiometricsPermission()
        wait(for: [expect], timeout: 1)
    }
    
    func testShowBiometricsPermission() {
        XCTAssertNotNil(sut.showBiometricsPermission(authenticated: true))
        XCTAssertNotNil(sut.showBiometricsPermission(authenticated: false))
    }
    
    func testShowError() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: sut)
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()

        let expectation = self.expectation(description: "Expect wait")
        
        sut.showError(error: ErrorResponse.getDefaultError(type: .biometric))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1.5)
        let alert = self.sut.navigationController?.visibleViewController as? UIAlertController
        alert?.tapButtons()
        XCTAssertTrue(self.sut.navigationController?.visibleViewController is UIAlertController)
    }
    
    func testShowSuccessLogIn( ){
        XCTAssertNotNil(sut.showSuccessLogIn())
    }
}
