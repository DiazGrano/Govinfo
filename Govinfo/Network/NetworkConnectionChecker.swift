//
//  NetworkConnectionChecker.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 17/12/23.
//

import Foundation

class NetworkConnectionChecker {
    func checkReachability(enabled: @escaping (Bool) -> Void) {
        NetworkManager().request(url: BasePath.google.rawValue, method: .head) { _ in
            enabled(true)
        } failure: { errorResponse in
            enabled(false)
        }
    }
}
