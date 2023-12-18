//
//  DetailsViewControllerMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class DetailsViewControllerMock: DetailsViewControllerProtocol, DetailsViewUIProtocol {
    var expectShowDetails: XCTestExpectation?
    var expectShowError: XCTestExpectation?
    var expectShowErrorWhatsApp: XCTestExpectation?
    var expectShareDetailsToWhatsApp: XCTestExpectation?

    func showDetails(elements: [GovinfoLabelViewUI]) {
        expectShowDetails?.fulfill()
    }
    
    func showError(error: ErrorResponse) {
        if error.defaultErrorType == .whatsapp {
            expectShowErrorWhatsApp?.fulfill()
        } else {
            expectShowError?.fulfill()
        }
    }
    
    func shareDetailsToWhatsApp() {
        expectShareDetailsToWhatsApp?.fulfill()
    }
}
