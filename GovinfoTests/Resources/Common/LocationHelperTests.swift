//
//  LocationHelperTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class LocationHelperTests: XCTestCase {
    var sut: LocationHelper!
    
    override func setUpWithError() throws {
        sut = LocationHelper()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testRequestLocationPermission() {
        XCTAssertNotNil(sut.requestLocationPermission())
    }
    
    func testGetCoordinates() {
        let expect = expectation(description: "Test get coordinates")
        sut.getCoordinates { latitude, longitude in
            expect.fulfill()
        } notAvailable: {
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 1)
    }
}
