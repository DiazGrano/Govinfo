//
//  NetworkManager.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case head = "HEAD"
}

class NetworkManager {
    func request<responseType: Decodable>(url: String,
                                          method: RequestMethod,
                                          responseType: responseType.Type,
                                          success: @escaping (_ modelResponse: responseType) -> Void,
                                          failure: @escaping (_ errorResponse: ErrorResponse) -> Void) {
        request(url: url, method: method) { responseData in
            guard let decodedResponse = try? JSONDecoder().decode(responseType.self, from: responseData) else {
                failure(ErrorResponse.getDefaultError(type: .badResponseBody))
                return
            }
            success(decodedResponse)
        } failure: { errorResponse in
            failure(errorResponse)
        }
    }
    
    func request(url: String,
                 method: RequestMethod,
                 success: @escaping (_ responseData: Data) -> Void,
                 failure: @escaping (_ errorResponse: ErrorResponse) -> Void) {
        guard let notNilURL = URL(string: url) else {
            failure(ErrorResponse.getDefaultError(type: .badURL))
            return
        }
        
        var request = URLRequest(url: notNilURL)
        request.httpMethod = method.rawValue
        
        URLSession.shared.dataTask(with: request) { responseData, responseURL, error in
            guard let notNilResponseData = responseData, let httpErrorResponse = responseURL as? HTTPURLResponse else {
                guard let nsError = error as? NSError else {
                    failure(ErrorResponse.getDefaultError(type: .unknown))
                    return
                }
                
                failure(ErrorResponse(code: "\(nsError.code)", message: nsError.localizedDescription, error: nsError))
                return
            }
            
            let statusCode = httpErrorResponse.statusCode
            
            guard (200...299) ~= statusCode else {
                failure(ErrorResponse(code: "\(statusCode)", message: HTTPURLResponse.localizedString(forStatusCode: statusCode), error: error))
                return
            }
            
            success(notNilResponseData)
        }.resume()
    }
}
