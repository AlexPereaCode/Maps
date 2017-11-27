//
//  MainMapLocationExtension.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension MainMapViewController {
    
    internal func initializeLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation: CLLocation = locations[0]
        currentLocationsArray.append(currentLocation)
        
        let coordinateSpan: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let locationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        let coordinateRegion: MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, coordinateSpan)
        
        mapView.setRegion(coordinateRegion, animated: true)
        drawTrackInMap()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
    }
}
