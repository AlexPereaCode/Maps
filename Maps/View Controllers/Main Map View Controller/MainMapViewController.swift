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

class MainMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet internal var mapView: MKMapView!
    @IBOutlet private var buttonTracking: TrackingButton!
    
    // MARK: - Properties
    internal let manager = CLLocationManager()
    internal var currentLocationsArray = [CLLocation]()
    private var isRecording: Bool = false

    // MARK: - Life Cycle Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNotifications()
        initializeMapView()
        initializeLocationManager()
        buttonTracking.setTrackingButton(active: false)
    }
    
    @objc func didEnterBackground(_ notification: Notification) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            if isRecording {
                manager.startMonitoringSignificantLocationChanges()
                print("Record in Background")
            }
        case .authorizedWhenInUse:
            if isRecording {
                print("Save route")
                saveLocations(name: "Save for enter background")
                buttonTracking.setTrackingButton(active: false)
                removeRoute()
            }
        case .denied :
            if isRecording {
                print("Remove route")
                removeRoute()
            }
        default:
            break
        }
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        if CLLocationManager.authorizationStatus() == .authorizedAlways && isRecording {
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    // MARK: - Private Functions
    private func initializeNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    private func initializeMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
    }
    
    private func isAuthorizedStatus() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    internal func removeRoute() {
        if isRecording {
            manager.stopUpdatingLocation()
            currentLocationsArray = []
            let overlays: [MKOverlay] = mapView.overlays
            mapView.removeOverlays(overlays)
            isRecording = false
        }
    }
    
    // MARK: - Internal Functions
    internal func drawTrackInMap() {
        if !currentLocationsArray.isEmpty && currentLocationsArray.count > 1 {
            let sourceIndex: Int = currentLocationsArray.count - 1
            let destinationIndex: Int = currentLocationsArray.count - 2
            let coordinateSource: CLLocationCoordinate2D = currentLocationsArray[sourceIndex].coordinate
            let coordinateDestination: CLLocationCoordinate2D = currentLocationsArray[destinationIndex].coordinate
            let coordinateArray: [CLLocationCoordinate2D] = [coordinateSource, coordinateDestination]
            let polyline = MKPolyline(coordinates: coordinateArray, count: coordinateArray.count)
            mapView.add(polyline)
        }
    }
    
    // MARK: - IBActions
    @IBAction func buttonTrackingPressed(_ sender: TrackingButton) {
        if isAuthorizedStatus() {
            if sender.isTrackingPositionActive() {
                presentAlertStopTracking()
            } else {
                isRecording = true
                manager.startUpdatingLocation()
            }
            sender.setTrackingButton(active: !sender.isTrackingPositionActive())
        } else {
            presentNotAuthorizedLocation()
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = .blue
            polylineRenderer.lineWidth = 5.0
            
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    
    // MARK: - Save to User Defaults
    internal func saveLocations(name: String) {
        var routesArray = UserDefaultsHelper.getLocations()
        let currentRoute = LocationData(routeName: name, locationArray: currentLocationsArray)
        routesArray.append(currentRoute)
        UserDefaultsHelper.setLocations(array: routesArray)
        removeRoute()
    }

}

