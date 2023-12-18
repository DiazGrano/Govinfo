//
//  FailureResponse.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

enum DefaultErrorResponseType {
    case unknown
    case badURL
    case badResponseBody
    case badRequestBody
    case noInternet
    case biometric
    case whatsapp
    
    func getCode() -> String {
        switch self {
        case .unknown:
            return GovinfoConstants.ErrorCodes.unknown
        case .badURL:
            return GovinfoConstants.ErrorCodes.badURL
        case .badResponseBody:
            return GovinfoConstants.ErrorCodes.badResponseBody
        case .badRequestBody:
            return GovinfoConstants.ErrorCodes.badRequestBody
        case .noInternet:
            return GovinfoConstants.ErrorCodes.noInternet
        case .biometric:
            return GovinfoConstants.ErrorCodes.biometric
        case .whatsapp:
            return GovinfoConstants.ErrorCodes.whatsapp
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .unknown, .whatsapp, .noInternet:
            return "Alerts.title.oops".localized
        case .badURL, .badResponseBody, .badRequestBody, .biometric:
            return "Alerts.title.odd".localized
        }
    }
    
    func getMessage() -> String {
        switch self {
        case .unknown:
            return "Alerts.message.unknown".localized
        case .badURL:
            return "Alerts.message.badURL".localized
        case .badResponseBody:
            return "Alerts.message.badResponseBody".localized
        case .badRequestBody:
            return "Alerts.message.badRequestBody".localized
        case .noInternet:
            return "Alerts.message.noInternet".localized
        case .biometric:
            return "Alerts.message.biometric".localized
        case .whatsapp:
            return "Alerts.message.whatsapp".localized
        }
    }
}

struct ErrorResponse {
    let code: String
    let title: String
    let message: String
    let error: Error?
    
    init(code: String = DefaultErrorResponseType.unknown.getCode(),
         title: String = DefaultErrorResponseType.unknown.getTitle(),
         message: String = DefaultErrorResponseType.unknown.getMessage(),
         error: Error? = nil) {
        self.code = code
        self.title = title
        self.message = message
        self.error = error
    }
    
    init(code: String = DefaultErrorResponseType.unknown.getCode(),
         title: String = DefaultErrorResponseType.unknown.getTitle(),
         message: String? = DefaultErrorResponseType.unknown.getMessage(),
         error: Error? = nil) {
        self.code = code
        self.title = title
        self.message = message ?? DefaultErrorResponseType.unknown.getMessage()
        self.error = error
    }
    
    static func getDefaultError(type: DefaultErrorResponseType) -> ErrorResponse {
        return ErrorResponse(code: type.getCode(), title: type.getTitle(), message: type.getMessage())
    }
    
    func getFullMessage() -> String {
        return ("\("Alerts.code.code".localized): \(code)" + "\n" + "\(message)")
    }
}
