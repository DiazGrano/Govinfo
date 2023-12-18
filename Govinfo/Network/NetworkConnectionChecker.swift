//
//  NetworkConnectionChecker.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import Foundation

class NetworkConnectionChecker {
    var networkManager = NetworkManager()
    
    func checkReachability(enabled: @escaping (Bool) -> Void) {
        networkManager.request(url: BasePath.google.rawValue, method: .head) { _ in
            enabled(true)
        } failure: { errorResponse in
            enabled(false)
        }
    }
}
