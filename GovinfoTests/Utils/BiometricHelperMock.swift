//
//  BiometricHelperMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import Foundation
@testable import Govinfo

class BiometricHelperMock: BiometricAuthHelper {
    var isSuccess: Bool
    var isAvailable: Bool
    
    init(isSuccess: Bool = true, isAvailable: Bool = true) {
        self.isSuccess = isSuccess
        self.isAvailable = isAvailable
    }
    
    override func areBiometricsAvailable() -> Bool {
        return isSuccess
    }
    
    override func authenticate(completion: @escaping (_ authenticated: Bool) -> Void, notAvailable: @escaping () -> Void) {
        guard isAvailable else {
            notAvailable()
            return
        }
        
        completion(isSuccess)
    }
}
