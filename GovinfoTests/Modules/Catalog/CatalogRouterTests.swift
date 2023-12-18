//
//  CatalogRouterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class CatalogRouterTests: XCTestCase {
    var sut: CatalogRouter!
    
    override func setUpWithError() throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: CatalogViewController(presenter: CatalogPresenterMock()))
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()
        
        sut = CatalogRouter(navigation: navigation)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStart() {
        XCTAssertNotNil(sut.start(facts: GovFactsResponse()))
        XCTAssertTrue(sut.navigation.topViewController is CatalogViewController)
    }
    
    func testGoToDetails() {
        sut.goToFactDetails(fact: Fact())
        XCTAssertTrue(sut.navigation.topViewController is CatalogViewController)
    }
}
