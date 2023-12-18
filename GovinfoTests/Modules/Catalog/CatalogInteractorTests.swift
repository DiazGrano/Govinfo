//
//  CataCatalogteractorTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class CatalogInteractorTests: XCTestCase {
    var sut: CatalogInteractor!
    var presenterMock: CatalogPresenterMock!
    
    override func setUpWithError() throws {
        sut = CatalogInteractor()
        presenterMock = CatalogPresenterMock()
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
