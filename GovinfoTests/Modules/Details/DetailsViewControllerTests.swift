//
//  DetailsViewControllerTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class DetailsViewControllerTests: XCTestCase {
    var sut: DetailsViewController!
    var presenterMock: DetailsPresenterMock!
    
    override func setUpWithError() throws {
        presenterMock = DetailsPresenterMock()
        sut = DetailsViewController(presenter: presenterMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        presenterMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(DetailsViewController(coder: NSCoder()))
    }
    
    func testShowDetails() {
        XCTAssertNotNil(sut.showDetails(elements: [GovinfoLabelViewUI()]))
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
    
    func testShareDetailsToWhatsApp() {
        let expect = expectation(description: "Test share details to whatsapp")
        presenterMock.expectSendDetailsToWhatsApp = expect
        sut.shareDetailsToWhatsApp()
        wait(for: [expect], timeout: 1)
    }
}
