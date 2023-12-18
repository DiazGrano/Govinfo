//
//  LoginInteractor.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class LoginInteractor {
    private weak var presenter: LoginPresenterProtocol?
    private let emailSuffix = "@govinfo.com"
    
    func setPresenter(_ presenter: LoginPresenterProtocol) {
        self.presenter = presenter
    }
    
    private func getFormattedLogInModel(model: LoginRequest) -> LoginRequest{
        return LoginRequest(user: model.user + emailSuffix, pass: model.pass)
    }
    
    private func saveUserData(_ save: Bool, _ model: LoginRequest) {
        guard save else {
            deleteLoginData()
            return
        }
        
        UserDefaults.standard.set(true, forKey: LoginKeys.biometrics)
        UserDefaults.standard.set(false, forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.set(model.user, forKey: LoginKeys.user)
        UserDefaults.standard.set(model.pass, forKey: LoginKeys.pass)
    }
    
    private func saveGoogleData(_ save: Bool, _ idToken: String, _ accessToken: String) {
        guard save else {
            deleteLoginData()
            return
        }
        
        UserDefaults.standard.set(true, forKey: LoginKeys.biometrics)
        UserDefaults.standard.set(true, forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.set(idToken, forKey: LoginKeys.idToken)
        UserDefaults.standard.set(accessToken, forKey: LoginKeys.accessToken)
    }
    
    private func deleteLoginData() {
        UserDefaults.standard.set(false, forKey: LoginKeys.biometrics)
        UserDefaults.standard.removeObject(forKey: LoginKeys.user)
        UserDefaults.standard.removeObject(forKey: LoginKeys.pass)
        UserDefaults.standard.removeObject(forKey: LoginKeys.isGoogleLogin)
        UserDefaults.standard.removeObject(forKey: LoginKeys.idToken)
        UserDefaults.standard.removeObject(forKey: LoginKeys.accessToken)
    }
    
    private func loginWithGoogle(useBiometrics: Bool, idToken: String, accessToken: String) {
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)

        Auth.auth().signIn(with: credential) { [unowned self] authResult, error in
            guard error == nil else {
                self.presenter?.fetchedError(error: ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: error?.localizedDescription, error: error))
                return
            }
            self.saveGoogleData(useBiometrics, idToken, accessToken)
            self.presenter?.fetchedLogIn()
        }
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    func getUserLogIn(model: LoginRequest, useBiometrics: Bool) {
        let formattedModel = getFormattedLogInModel(model: model)
        Auth.auth().signIn(withEmail: formattedModel.user, password: formattedModel.pass) { [unowned self] authResult, error in
            guard authResult != nil, error == nil else {
                self.presenter?.fetchedError(error: ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: error?.localizedDescription))
                return
            }
            
            self.saveUserData(useBiometrics, model)
            
            self.presenter?.fetchedLogIn()
        }
    }
    
    func getUserRegistration(model: LoginRequest, useBiometrics: Bool) {
        let formattedModel = getFormattedLogInModel(model: model)
        Auth.auth().createUser(withEmail: formattedModel.user, password: formattedModel.pass) { [unowned self] authResult, error in
            guard authResult != nil, error == nil else {
                self.presenter?.fetchedError(error: ErrorResponse(code: GovinfoConstants.ErrorCodes.register, message: error?.localizedDescription))
                return
            }
            
            self.saveUserData(useBiometrics, model)
            
            self.presenter?.fetchedLogIn()
        }
    }
    
    func getGoogleLogIn(controller: UIViewController, useBiometrics: Bool) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            self.presenter?.fetchedError(error: ErrorResponse.getDefaultError(type: .unknown))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { [unowned self] result, error in
            guard let user = result?.user, let idToken = user.idToken?.tokenString, error == nil else {
                self.presenter?.fetchedError(error: ErrorResponse(code: GovinfoConstants.ErrorCodes.login, message: error?.localizedDescription, error: error))
                return
            }
            
            self.loginWithGoogle(useBiometrics: useBiometrics, idToken: idToken, accessToken: user.accessToken.tokenString)
        }
    }
    
    func getBiometricsLogIn() {
        if UserDefaults.standard.bool(forKey: LoginKeys.isGoogleLogin) {
            guard let idToken = UserDefaults.standard.string(forKey: LoginKeys.idToken), let accessToken = UserDefaults.standard.string(forKey: LoginKeys.accessToken) else {
                self.presenter?.fetchedError(error: ErrorResponse(code: GovinfoConstants.ErrorCodes.login))
                return
            }
            loginWithGoogle(useBiometrics: true, idToken: idToken, accessToken: accessToken)
        } else {
            guard let user = UserDefaults.standard.string(forKey: LoginKeys.user), let pass = UserDefaults.standard.string(forKey: LoginKeys.pass) else {
                self.presenter?.fetchedError(error: ErrorResponse(code: GovinfoConstants.ErrorCodes.login))
                return
            }
            getUserLogIn(model: LoginRequest(user: user, pass: pass), useBiometrics: true)
        }
    }
    
    func getBiometricsPermission() {
        BiometricAuthHelper().authenticate { [unowned self] authenticated in
            self.presenter?.fetchedBiometricsPermission(authenticated: authenticated)
        } notAvailable: {
            self.presenter?.fetchedError(error: ErrorResponse.getDefaultError(type: .biometric))
        }
    }
}
