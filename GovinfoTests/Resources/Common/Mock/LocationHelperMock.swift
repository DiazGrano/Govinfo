//
//  LocationHelperMock.swift
//  GovinfoTests
//
//  Created by Luis Enrique Diaz Grano on 18/12/23.
//

import Foundation
@testable import Govinfo

class LocationHelperMock: LocationHelper {
    var latitude: String
    var longitude: String
    var isAvailable: Bool
    
    init(latitude: String = "", longitude: String = "", isAvailable: Bool = true) {
        self.latitude = latitude
        self.longitude = longitude
        self.isAvailable = isAvailable
    }
    
    override func getCoordinates(completion: ((String, String) -> Void)?, notAvailable: @escaping () -> Void) {
        guard isAvailable else {
            notAvailable()
            return
        }
        
        completion?(latitude, longitude)
    }
}
