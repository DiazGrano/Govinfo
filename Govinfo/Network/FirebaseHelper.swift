//
//  FirebaseHelper.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class FirebaseHelper {
    func signIn(model: LoginRequest,
                success: @escaping () -> Void,
                failure: @escaping (_ errorResponse: ErrorResponse) -> Void) {
        Auth.auth().signIn(withEmail: model.user, password: model.pass) { authResult, error in
            guard authResult != nil, error == nil else {
                failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: error?.localizedDescription, error: error))
                return
            }
            
            success()
        }
    }
    
    func signIn(idToken: String,
                accessToken: String,
                success: @escaping () -> Void,
                failure: @escaping (_ errorResponse: ErrorResponse) -> Void) {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            guard error == nil else {
                failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: error?.localizedDescription, error: error))
                return
            }
            
            success()
        }
    }
    
    
    func createUser(model: LoginRequest,
                    success: @escaping () -> Void,
                    failure: @escaping (_ errorResponse: ErrorResponse) -> Void) {
        Auth.auth().createUser(withEmail: model.user, password: model.pass) { authResult, error in
            guard authResult != nil, error == nil else {
                failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.register, message: error?.localizedDescription, error: error))
                return
            }
            
            success()
        }
    }
    
    func getGoogleTokens(withPresenting: UIViewController,
                         success: @escaping (_ idToken: String, _ accessToken: String) -> Void,
                         failure: @escaping (_ errorResponse: ErrorResponse) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            failure(ErrorResponse.getDefaultError(type: .unknown))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance.signIn(withPresenting: withPresenting) { result, error in
                guard let user = result?.user, let idToken = user.idToken?.tokenString, error == nil else {
                    failure(ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: error?.localizedDescription, error: error))
                    return
                }
                
                success(idToken, user.accessToken.tokenString )
            }
        }
    }
    
}
