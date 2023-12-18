//
//  SplashViewUITests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class SplashViewUITests: XCTestCase {
    var sut: SplashViewUI!
    var viewMock: SplashViewControllerMock!
    
    override func setUpWithError() throws {
        viewMock = SplashViewControllerMock()
        sut = SplashViewUI(delegate: viewMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(SplashViewUI(coder: NSCoder()))
    }
}
