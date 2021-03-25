//
//  LocationManager.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 23/03/21.
//

import UIKit
import CoreLocation

protocol LocationManagerProtocol{
    func didUpdateToLocation(location:CLLocation) -> Void
}

class LocationManager: NSObject {

    static let sharedManager = LocationManager()
    var delegate:LocationManagerProtocol?
    
    var locationManager:CLLocationManager = {
        
        let locManager = CLLocationManager()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()
        return locManager
        
    }()
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
}

extension LocationManager:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let loc = locations[0]
        
        if loc.coordinate.latitude > 0.0 && loc.coordinate.longitude > 0.0 {
            self.delegate?.didUpdateToLocation(location:loc)
            self.locationManager.stopUpdatingLocation()
        }
    }
    
}
