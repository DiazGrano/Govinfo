//
//  BiometricAuthManager.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 14/12/23.
//

import Foundation
import LocalAuthentication

class BiometricAuthHelper {
    func areBiometricsAvailable() -> Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticate(completion: @escaping (_ authenticated: Bool) -> Void, notAvailable: @escaping () -> Void) {
        let localAuth = LAContext()
        localAuth.localizedFallbackTitle = "Biometrics.fallbackMessage".localized
        
        guard areBiometricsAvailable() else {
            notAvailable()
            return
        }
        
        localAuth.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                 localizedReason: "Biometrics.authMesasage".localized) { success, _ in
            completion(success)
        }
    }
}
