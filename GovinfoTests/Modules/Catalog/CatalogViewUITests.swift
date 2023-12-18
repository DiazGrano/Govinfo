//
//  CatalogViewUITests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import Foundation
import XCTest
@testable import Govinfo

final class CatalogViewUITests: XCTestCase {
    var sut: CatalogViewUI!
    var viewMock: CatalogViewControllerMock!
    
    override func setUpWithError() throws {
        viewMock = CatalogViewControllerMock()
        sut = CatalogViewUI(delegate: viewMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(CatalogViewUI(coder: NSCoder()))
    }
    
    func testCatalogViewCellTapped() {
        let expect = expectation(description: "Test catalog view cell tapped")
        viewMock.expectShowDetails = expect
        sut.catalogViewCellTapped(data: Fact())
        wait(for: [expect], timeout: 1)
    }
    
    func testSetFactsFilter() {
        let expect = expectation(description: "Test set facts filter")
        viewMock.expectSetFactsFilter = expect
        sut.govinfoTextfieldViewUITextChanged(textField: sut.searchTextfield)
        wait(for: [expect], timeout: 1)
    }
    
    func testResignFirstResponder() {
        XCTAssertNotNil(sut.govinfoTextfieldViewUIDone(textField: sut.searchTextfield))
    }
    
    func testTableViewCellForRow() {
        let expect = expectation(description: "Test table view cell for row")
        viewMock.expectGetFactsModel = expect
        let cell = sut.tableView(sut.factsTable, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is CatalogViewCell)
        
        wait(for: [expect], timeout: 0.5)
    }
    
    func testTableViewCellForRowEmptyModel() {
        let expect = expectation(description: "Test tableview cell for row empty model")
        viewMock.expectGetFactsModel = expect
        viewMock.factsModel = []
        let cell = sut.tableView(sut.factsTable, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertFalse(cell is CatalogViewCell)
        
        wait(for: [expect], timeout: 0.5)
    }
    
    func testTableViewNumberOfRowsInSection() {
        let expect = expectation(description: "Test tableview number of rows in section")
        viewMock.expectGetFactsModel = expect
        let count = sut.tableView(sut.factsTable, numberOfRowsInSection: 0)
        XCTAssertEqual(count, viewMock.factsModel.count)
        
        wait(for: [expect], timeout: 0.5)
    }
    
    func testTableViewNumberOfRowsInSectionEmpty() {
        let expect = expectation(description: "Test tableview number of rows in section empty")
        viewMock.expectGetFactsModel = expect
        viewMock.factsModel = []
        let count = sut.tableView(sut.factsTable, numberOfRowsInSection: 0)
        XCTAssertEqual(count, 0)
        
        wait(for: [expect], timeout: 0.5)
    }
}
