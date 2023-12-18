//
//  FirebaseHelperMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import UIKit
@testable import Govinfo


class FirebaseHelperMock: FirebaseHelper {
    var isSuccess: Bool
    
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }

    override func signIn(model: LoginRequest, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        guard isSuccess else {
            failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: ""))
            return
        }
        
        success()
    }
    
    override func signIn(idToken: String, accessToken: String, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        guard isSuccess else {
            failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: ""))
            return
        }
        
        success()
    }
    
    override func createUser(model: LoginRequest, success: @escaping () -> Void, failure: @escaping (ErrorResponse) -> Void) {
        guard isSuccess else {
            failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.register, message: ""))
            return
        }
        
        success()
    }
    
    override func getGoogleTokens(withPresenting: UIViewController, success: @escaping (String, String) -> Void, failure: @escaping (ErrorResponse) -> Void) {
        guard isSuccess else {
            failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: ""))
            return
        }
        
        success("", "")
    }
}
