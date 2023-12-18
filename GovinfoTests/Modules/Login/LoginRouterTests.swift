//
//  SplasRouterTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class LoginRouterTests: XCTestCase {
    var sut: LoginRouter!
    
    override func setUpWithError() throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: LoginViewController(presenter: LoginPresenterMock()))
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()
        
        sut = LoginRouter(navigation: navigation)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStart() {
        XCTAssertNotNil(sut.start(facts: GovFactsResponse()))
    }
    
    func testGoToDataTables() {
        sut.goToDataTables(facts: GovFactsResponse())
        XCTAssertTrue(sut.navigation.topViewController is LoginViewController)
    }
}
