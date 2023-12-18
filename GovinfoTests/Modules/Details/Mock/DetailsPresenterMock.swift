//
//  DetailsPresenterMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

@testable import Govinfo
import XCTest

class DetailsPresenterMock: DetailsPresenterProtocol  {
    var expectFetchDetails: XCTestExpectation?
    var expectSendDetailsToWhatsApp: XCTestExpectation?
    
    func fetchDetails() {
        expectFetchDetails?.fulfill()
    }
    
    func sendDetailsToWhatsApp() {
        expectSendDetailsToWhatsApp?.fulfill()
    }
}
