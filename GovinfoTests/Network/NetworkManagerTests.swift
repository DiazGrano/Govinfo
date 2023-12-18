//
//  NetworkManagerTests.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import XCTest
@testable import Govinfo

final class NetworkManagerTests: XCTestCase {
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testRequestWithResponse() {
        let expect = expectation(description: "Test request with response")
        sut.request(url: URLsHelper.govFacts, method: .get, responseType: GovFactsResponse.self) { modelResponse in
            expect.fulfill()
        } failure: { errorResponse in
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testRequestWithResponseError() {
        let expect = expectation(description: "Test request with response")
        let urlError = (BasePath.govData.rawValue + Endpoint.facts.rawValue + "?pageSize=Error")
        sut.request(url: urlError, method: .get, responseType: GovFactsResponse.self) { modelResponse in } failure: { errorResponse in
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
    
    func testRequest() {
        let expect = expectation(description: "Test request with response")
        sut.request(url: BasePath.google.rawValue, method: .head) { responseData in
            expect.fulfill()
        } failure: { errorResponse in
            expect.fulfill()
        }
        wait(for: [expect], timeout: 5)
    }
}
