//
//  LoginInteractor.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

class LoginInteractor {
    private weak var presenter: LoginPresenterProtocol?
    private let emailSuffix = "@govinfo.com"
    var firebaseHelper = FirebaseHelper()
    var biometricHelper = BiometricAuthHelper()
    
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
    
    func loginWithGoogle(useBiometrics: Bool, idToken: String, accessToken: String) {
        firebaseHelper.signIn(idToken: idToken, accessToken: accessToken) { [unowned self] in
            self.saveGoogleData(useBiometrics, idToken, accessToken)
            self.presenter?.fetchedLogIn()
        } failure: { [unowned self] errorResponse in
            self.presenter?.fetchedError(error: errorResponse)
        }
    }
}

extension LoginInteractor: LoginInteractorProtocol {
    func getUserLogIn(model: LoginRequest, useBiometrics: Bool) {
        let formattedModel = getFormattedLogInModel(model: model)
        
        firebaseHelper.signIn(model: formattedModel) { [unowned self] in
            self.saveUserData(useBiometrics, model)
            self.presenter?.fetchedLogIn()
        } failure: { [unowned self] errorResponse in
            self.presenter?.fetchedError(error: errorResponse)
        }
    }
    
    func getUserRegistration(model: LoginRequest, useBiometrics: Bool) {
        let formattedModel = getFormattedLogInModel(model: model)
        
        firebaseHelper.createUser(model: formattedModel) { [unowned self] in
            self.saveUserData(useBiometrics, model)
            self.presenter?.fetchedLogIn()
        } failure: { [unowned self] errorResponse in
            self.presenter?.fetchedError(error: errorResponse)
        }
    }
    
    func getGoogleLogIn(controller: UIViewController, useBiometrics: Bool) {
        firebaseHelper.getGoogleTokens(withPresenting: controller) { [unowned self] idToken, accessToken in
            self.loginWithGoogle(useBiometrics: useBiometrics, idToken: idToken, accessToken: accessToken)
        } failure: { [unowned self] errorResponse in
            self.presenter?.fetchedError(error: errorResponse)
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
        biometricHelper.authenticate { [unowned self] authenticated in
            self.presenter?.fetchedBiometricsPermission(authenticated: authenticated)
        } notAvailable: {
            self.presenter?.fetchedError(error: ErrorResponse.getDefaultError(type: .biometric))
        }
    }
}
