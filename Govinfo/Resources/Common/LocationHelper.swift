//
//  LocationHelper.swift
//  Govinfo
//
//  Created by Luis Enrique Diaz Grano on 16/12/23.
//

import Foundation
import MapKit
import CoreLocation

class LocationHelper: NSObject {
    private var completion: ((String, String) -> Void)?
    private var manager = CLLocationManager()

    func requestLocationPermission() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled() else {
                return
            }
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    func getCoordinates(completion: ((_ latitude: String, _ longitude: String) -> Void)?, notAvailable: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled(),
                  CLLocationManager.authorizationStatus() != .denied,
                  CLLocationManager.authorizationStatus() != .restricted else {
                DispatchQueue.main.async {
                    notAvailable()
                }
                return
            }

            self.completion = completion
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            self.manager.requestWhenInUseAuthorization()
            self.manager.startUpdatingLocation()
        }
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        DispatchQueue.main.async {
            guard let location = locations.last else {
                return
            }
            
            self.completion?(String(location.coordinate.latitude), String(location.coordinate.longitude))
            self.completion = nil
            manager.stopUpdatingLocation()
        }
    }
}


