//
//  CatalogViewControllerTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class CatalogViewControllerTests: XCTestCase {
    var sut: CatalogViewController!
    var presenterMock: CatalogPresenterMock!
    
    override func setUpWithError() throws {
        presenterMock = CatalogPresenterMock()
        sut = CatalogViewController(presenter: presenterMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(CatalogViewController(coder: NSCoder()))
    }
    
    func testGetFactsModel() {
        let expect = expectation(description: "Test get facts model")
        presenterMock.expectFetchFacts = expect
        let _ = sut.getFactsModel()
        
        wait(for: [expect], timeout: 1)
    }
    
    func testSetFactsFilter() {
        let expect = expectation(description: "Test set facts filter")
        presenterMock.expectSetFactsFilter = expect
        sut.setFactsFilter(name: "SEDENA")
        wait(for: [expect], timeout: 1)
    }
    
    func testShowDetails() {
        let expect = expectation(description: "Test show details")
        presenterMock.expectFetchFactDetails = expect
        sut.showDetails(fact: Fact())
        wait(for: [expect], timeout: 1)
    }
    
    func testLoadView() {
        XCTAssertNil(sut.ui)
        sut.loadView()
        XCTAssertNotNil(sut.ui)
        XCTAssertEqual(sut.ui, sut.view)
    }
    
    func testViewDidAppear() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: sut)
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()
        
        sut.navigationController?.setNavigationBarHidden(true, animated: false)
        XCTAssertTrue(sut.navigationController?.isNavigationBarHidden ?? false)
        sut.viewDidAppear(true)
        XCTAssertFalse(sut.navigationController?.isNavigationBarHidden ?? true)
    }
}
