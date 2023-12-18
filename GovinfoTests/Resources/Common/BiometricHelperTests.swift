//
//  BiometricHelperTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class BiometricHelperTests: XCTestCase {
    var sut: BiometricAuthHelper!
    
    override func setUpWithError() throws {
        sut = BiometricAuthHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAreBiometricsAvailable() {
        XCTAssertNotNil(sut.areBiometricsAvailable())
    }
    
    func testAuthenticate() {
        let expect = expectation(description: "Test authenticate")
        sut.authenticate { authenticated in
            expect.fulfill()
        } notAvailable: {
            expect.fulfill()
        }
        wait(for: [expect], timeout: 60)
    }
}
