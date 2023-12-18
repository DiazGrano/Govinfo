//
//  SplashEntityTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class SplashEntityTests: XCTestCase {
    var sut: GovFactsResponse!
    
    override func setUpWithError() throws {
        sut = GovFactsResponse(pagination: Pagination(), facts: [Fact()])
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
    }
    
    func testGetDictionary() {
        XCTAssertNotNil(sut.facts.first?.getDictionary())
        XCTAssertTrue(sut.facts.first?.getDictionary() is Array<(key: String, value: String)>)
    }
}
