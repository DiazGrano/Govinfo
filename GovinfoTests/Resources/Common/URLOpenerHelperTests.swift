//
//  URLOpenerHelperTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class URLOpenerHelperTests: XCTestCase {
    var sut: URLOpenerHelper!
    
    override func setUpWithError() throws {
        sut = URLOpenerHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testCanOpen() {
        let stringURL = "whatsapp://send?text=Hola"
        guard let url = URL(string: stringURL) else {
            return
        }
        
        if sut.canOpen(url) {
            XCTAssertNotNil(sut.open(url))
        } else {
           XCTAssertFalse(sut.canOpen(url))
        }
    }
    
    func testOpen() {
        let stringURL = "whatsapp://send?text=Hola"
        guard let url = URL(string: stringURL) else {
            return
        }
        XCTAssertNotNil(sut.open(url))
    }
}
