//
//  LoginViewUITests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class LoginViewUITests: XCTestCase {
    var sut: LoginViewUI!
    var viewMock: LoginViewControllerMock!
    
    override func setUpWithError() throws {
        viewMock = LoginViewControllerMock()
        sut = LoginViewUI(delegate: viewMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(LoginViewUI(coder: NSCoder()))
    }
    
    func testLoginUsingGoogle() {
        let expect = expectation(description: "Test login using google")
        viewMock.expectLogInWithGoogle = expect
        sut.logInUsingGoogle()
        wait(for: [expect], timeout: 1)
    }
    
    func testLogInUsingUserAndPass() {
        let expect = expectation(description: "Test login using user and pass")
        viewMock.expectLogInWithUserAndPass = expect
        sut.userTextfield.text = "user"
        sut.passTextfield.text = "pass"
        sut.logInUsingUserAndPass()
        wait(for: [expect], timeout: 1)
    }
    
    func testLogInUsingUserAndPassError() {
        sut.userTextfield.text = " "
        sut.passTextfield.text = ""
        sut.logInUsingUserAndPass()
        XCTAssertFalse(sut.userTextfield.isTextValid)
        XCTAssertFalse(sut.passTextfield.isTextValid)
    }
    
    func testRegisterUsingUserAndPass() {
        let expect = expectation(description: "Test register using user and pass")
        viewMock.expectRegisterUser = expect
        sut.userTextfield.text = "user"
        sut.passTextfield.text = "pass"
        sut.registerUsingUserAndPass()
        wait(for: [expect], timeout: 1)
    }
    
    func testRegisterUsingUserAndPassError() {
        sut.userTextfield.text = " "
        sut.passTextfield.text = ""
        sut.registerUsingUserAndPass()
        XCTAssertFalse(sut.userTextfield.isTextValid)
        XCTAssertFalse(sut.passTextfield.isTextValid)
    }
    
    func testValidate() {
        sut.userTextfield.text = " "
        sut.passTextfield.text = ""
        XCTAssertFalse(sut.validate())
        
        sut.userTextfield.text = "user"
        sut.passTextfield.text = "password"
        XCTAssertTrue(sut.validate())
    }
    
    func testLogInManually() {
        sut.showViewComponents(biometricsSaved: true)
        sut.logInManually()
        
        XCTAssertFalse(sut.mainStackView.isHidden)
        XCTAssertTrue(sut.biometricLogInButton.isHidden)
        XCTAssertTrue(sut.changeToManualLoginButton.isHidden)
    }
    
    func testShowComponents() {
        sut.showViewComponents(biometricsSaved: true)
        XCTAssertTrue(sut.mainStackView.isHidden)
        XCTAssertFalse(sut.biometricLogInButton.isHidden)
        XCTAssertFalse(sut.changeToManualLoginButton.isHidden)
        
        sut.showViewComponents(biometricsSaved: false)
        XCTAssertFalse(sut.mainStackView.isHidden)
        XCTAssertTrue(sut.biometricLogInButton.isHidden)
        XCTAssertTrue(sut.changeToManualLoginButton.isHidden)
    }
    
    func testClearFields() {
        sut.userTextfield.text = "user"
        sut.passTextfield.text = "pass"
        sut.clearFields()
        XCTAssertTrue(sut.userTextfield.getText().isEmpty)
        XCTAssertTrue(sut.passTextfield.getText().isEmpty)
    }
    
    func testSetBiometricsCheckStatus() {
        let expectation = self.expectation(description: "Expect wait")
        sut.setBiometricsCheckStatus(status: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 1.5)
        XCTAssertTrue(sut.biometricCheckboxButton.status)
        
        
        let expectation2 = self.expectation(description: "Expect wait 2")
        sut.setBiometricsCheckStatus(status: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation2.fulfill()
        }
        self.wait(for: [expectation2], timeout: 3)
        XCTAssertFalse(sut.biometricCheckboxButton.status)
    }
    
    
    func testGovinfoTextfieldViewUIDone() {
        XCTAssertNotNil(sut.govinfoTextfieldViewUIDone(textField: sut.userTextfield))
        XCTAssertNotNil(sut.govinfoTextfieldViewUIDone(textField: sut.passTextfield))
    }
    
    func testBiometricStatus() {
        let expect = expectation(description: "Test biometric status")
        viewMock.expectLogInWithBiometrics = expect
        sut.biometricStatus(authenticated: true)
        wait(for: [expect], timeout: 1)
    }
    
    func testBiometricStatusError() {
        XCTAssertNotNil(sut.biometricStatus(authenticated: false))
    }
}
