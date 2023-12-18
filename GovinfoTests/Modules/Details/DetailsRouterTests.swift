//
//  DetailsRouterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class DetailsRouterTests: XCTestCase {
    var sut: DetailsRouter!
    
    override func setUpWithError() throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: DetailsViewController(presenter: DetailsPresenterMock()))
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()
        
        sut = DetailsRouter(navigation: navigation, fact: Fact())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStart() {
        XCTAssertNotNil(sut.start())
        XCTAssertTrue(sut.navigation.topViewController is DetailsViewController)
    }
}
