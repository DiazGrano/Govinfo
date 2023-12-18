//
//  LoginEntity.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import Foundation

struct LoginRequest {
    let user: String
    let pass: String
    
    init(user: String, pass: String) {
        self.user = user
        self.pass = pass
    }
}

enum LoginKeys {
    static let biometrics = "useBiometrics"
    static let isGoogleLogin = "isGoogleLogin"
    static let user = "user"
    static let pass = "pass"
    static let idToken = "idToken"
    static let accessToken = "accessToken"
}
