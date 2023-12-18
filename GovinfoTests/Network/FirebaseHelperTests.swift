//
//  FirebaseHelperTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class FirebaseHelperTests: XCTestCase {
    var sut: FirebaseHelper!
    
    override func setUpWithError() throws {
        sut = FirebaseHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testSignInUser() {
        let expect = expectation(description: "Test sign in user")
        sut.signIn(model: LoginRequest(user: "", pass: "")) {
            expect.fulfill()
        } failure: { errorResponse in
            expect.fulfill()
        }

        wait(for: [expect], timeout: 1)
    }
    
    func testSignInToken() {
        let expect = expectation(description: "Test sign in token")
        sut.signIn(idToken: "", accessToken: "") {
            expect.fulfill()
        } failure: { errorResponse in
            expect.fulfill()
        }

        wait(for: [expect], timeout: 1)
    }
    
    func testCreateUser() {
        let expect = expectation(description: "Test sign in token")
        sut.createUser(model: LoginRequest(user: "", pass: "")) {
            expect.fulfill()
        } failure: { errorResponse in
            expect.fulfill()
        }

        wait(for: [expect], timeout: 1)
    }
    
    func testGetGoogleTokens() {
        let expect = expectation(description: "Test get google tokens")
        sut.getGoogleTokens(withPresenting: UIViewController()) { idToken, accessToken in
            expect.fulfill()
        } failure: { errorResponse in
            expect.fulfill()
        }

        wait(for: [expect], timeout: 60)
    }
}
