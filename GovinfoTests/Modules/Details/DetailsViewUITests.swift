//
//  DetailsViewUITests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import Foundation
import XCTest
@testable import Govinfo

final class DetailsViewUITests: XCTestCase {
    var sut: DetailsViewUI!
    var viewMock: DetailsViewControllerMock!
    
    override func setUpWithError() throws {
        viewMock = DetailsViewControllerMock()
        sut = DetailsViewUI(delegate: viewMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewMock = nil
    }
    
    func testInitNil() {
        XCTAssertNil(DetailsViewUI(coder: NSCoder()))
    }
    
    func testLoadDetails() {
        XCTAssertTrue(sut.stackContainerHeightConstraint.isActive)
        let labels = [GovinfoLabelViewUI(), GovinfoLabelViewUI(), GovinfoLabelViewUI()]
        sut.loadDetails(elements: labels)
        let expect = expectation(description: "Expect wait")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expect.fulfill()
        }
        
        wait(for: [expect], timeout: 2)
        XCTAssertEqual(sut.mainStackView.arrangedSubviews.count, labels.count)
        XCTAssertFalse(sut.stackContainerHeightConstraint.isActive)
    }
    
    func testShareToWhatsApp() {
        let expect = expectation(description: "Test share to whatsapp")
        viewMock.expectShareDetailsToWhatsApp = expect
        sut.shareToWhatsApp()
        wait(for: [expect], timeout: 1)
    }
}
