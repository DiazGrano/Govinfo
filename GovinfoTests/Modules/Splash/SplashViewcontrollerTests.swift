//
//  SplashViewcontrollerTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import XCTest
@testable import Govinfo

final class SplashViewcontrollerTests: XCTestCase {
    var sut: SplashViewController!
    var presenterMock: SplashPresenterMock!
    
    override func setUpWithError() throws {
        presenterMock = SplashPresenterMock()
        sut = SplashViewController(presenter: presenterMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }
    
    func testShowSuccess() {
        let expect = expectation(description: "Test show success")
        sut.showSuccess()
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 7)
    }

    func testShowError() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(rootViewController: sut)
        appDelegate.window?.rootViewController = navigation
        appDelegate.window?.makeKeyAndVisible()

        let expectation = self.expectation(description: "Expect wait")
        
        sut.showError(error: ErrorResponse.getDefaultError(type: .unknown))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 1.5)
        let alert = self.sut.navigationController?.visibleViewController as? UIAlertController
        alert?.tapButtons()
        XCTAssertTrue(self.sut.navigationController?.visibleViewController is UIAlertController)
    }
    
    func testInit() {
        XCTAssertNil(SplashViewController(coder: NSCoder()))
    }
}
