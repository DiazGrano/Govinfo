//
//  NetworkManagerMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import Foundation
@testable import Govinfo

class NetworkManagerMock: NetworkManager {
    var isSuccess: Bool
    var successModel: Codable?
    var errorModel: ErrorResponse
    
    init(isSuccess: Bool = true, successModel: Codable? = nil, errorModel: ErrorResponse = ErrorResponse.getDefaultError(type: .unknown)) {
        self.isSuccess = isSuccess
        self.successModel = successModel
        self.errorModel = errorModel
    }
    
    override func request(url: String, method: RequestMethod, success: @escaping (Data) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        guard isSuccess else {
            failure(errorModel)
            return
        }
        
        guard let notNilSuccessModel = successModel, let responseData = try? JSONEncoder().encode(notNilSuccessModel) else {
            success(Data())
            return
        }
        
        success(responseData)
    }
    
    override func request<responseType>(url: String, method: RequestMethod, responseType: responseType.Type, success: @escaping (responseType) -> Void, failure: @escaping (ErrorResponse) -> Void) where responseType : Decodable {
        guard isSuccess else {
            failure(errorModel)
            return
        }
        
        guard let notNilSuccessModel = successModel, let responseData = try? JSONEncoder().encode(notNilSuccessModel) else {
            failure(ErrorResponse.getDefaultError(type: .badRequestBody))
            return
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(responseType.self, from: responseData) else {
            failure(ErrorResponse.getDefaultError(type: .badResponseBody))
            return
        }
        
        success(decodedResponse)
    }
}
