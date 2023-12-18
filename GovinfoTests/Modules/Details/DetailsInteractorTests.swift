//
//  DetailsInteractorTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class DetailsInteractorTests: XCTestCase {
    var sut: DetailsInteractor!
    var presenterMock: DetailsPresenterMock!
    
    override func setUpWithError() throws {
        sut = DetailsInteractor()
        presenterMock = DetailsPresenterMock()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }
    
    func testSetPresenter() {
        XCTAssertNil(sut.presenter)
        sut.setPresenter(presenterMock)
        XCTAssertNotNil(sut.presenter)
    }
}
