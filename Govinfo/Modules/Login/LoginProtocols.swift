//
//  LoginProtocols.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 13/12/23.
//

import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func showError(error: ErrorResponse)
    func showSuccessLogIn()
    func showBiometricsPermission(authenticated: Bool)
}

protocol LoginViewUIProtocol: AnyObject {
    func logInWithGoogle(useBiometrics: Bool)
    func logInWithUserAndPass(model: LoginRequest, useBiometrics: Bool)
    func registerUser(model: LoginRequest, useBiometrics: Bool)
    func logInWithBiometrics()
    func checkBiometricsPermission()
}

protocol LoginInteractorProtocol: AnyObject {
    func getUserLogIn(model: LoginRequest, useBiometrics: Bool)
    func getUserRegistration(model: LoginRequest, useBiometrics: Bool)
    func getGoogleLogIn(controller: UIViewController, useBiometrics: Bool)
    func getBiometricsLogIn()
    func getBiometricsPermission()
}

protocol LoginPresenterProtocol: AnyObject {
    func fetchUserLogIn(model: LoginRequest, useBiometrics: Bool)
    func fetchUserRegistration(model: LoginRequest, useBiometrics: Bool)
    func fetchGoogleLogIn(controller: UIViewController, useBiometrics: Bool)
    func fetchBiometricsLogIn()
    func fetchedLogIn()
    func fetchedError(error: ErrorResponse)
    func fetchBiometricsPermission()
    func fetchedBiometricsPermission(authenticated: Bool)
}

protocol LoginRouterProtocol: AnyObject {
    func goToDataTables(facts: GovFactsResponse)
}
