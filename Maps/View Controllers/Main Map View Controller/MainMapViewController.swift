//
//  ViewController.swift
//  Maps
//
//  Created by Alex on 24/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainMapViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var buttonTracking: TrackingButton!
    
    // MARK: - Properties
    private let manager = CLLocationManager()

    // MARK: - Life Cycle Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocationManager()
        setButtonTrackingInitialStatus()
    }
    
    // MARK: - Private Functions
    private func initializeLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        //manager.startUpdatingLocation()
        //manager.requestAlwaysAuthorization()
    }
    
    private func setButtonTrackingInitialStatus() {
        buttonTracking.setTrackingButton(active: false)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentLocation: CLLocation = locations[0]
        let coordinateSpan: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let locationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude)
        let coordinateRegion: MKCoordinateRegion = MKCoordinateRegionMake(locationCoordinate, coordinateSpan)
        
        mapView.region = coordinateRegion
    }
    
    // MARK: - IBActions
    @IBAction func buttonTrackingPressed(_ sender: TrackingButton) {
        if sender.isTrackingPositionActive() {
            manager.stopUpdatingLocation()
        } else {
            manager.startUpdatingLocation()
        }
        sender.setTrackingButton(active: !sender.isTrackingPositionActive())
        mapView.showsUserLocation = sender.isTrackingPositionActive()
    }
    
}

