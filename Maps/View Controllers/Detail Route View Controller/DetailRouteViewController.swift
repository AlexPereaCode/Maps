//
//  DetailRouteViewController.swift
//  Maps
//
//  Created by Alex on 26/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct InfoData {
    var averageSpeedString = String()
    var distance = String()
    var initialAltitude = String()
    var averageAltitude = String()
    var initialDate = String()
    var finalDate = String()
}

class DetailRouteViewController: UIViewController, MKMapViewDelegate, MoreInfoRouteCardViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var moreInfoRouteCardView: MoreInfoRouteCardView!
    @IBOutlet private var constraintHeightMoreInfoCardView: NSLayoutConstraint!
    @IBOutlet private var constraintTopMoreInfoCardView: NSLayoutConstraint!
    @IBOutlet private var barButtonExpandInfoCard: UIBarButtonItem!
    
    // MARK: - Properties
    internal var locationData: LocationData!
    private var moreInfoRouteInfoCardIsExpandMode: Bool = false
    private var mainScreenBounds = UIScreen.main.bounds
    internal var infoData = InfoData()
    
    // MARK: - Life Cycle Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        extractAllDetailStatisticsData()
        setInitialStatusMoreInfoCardView()
        initializeMapView()
        zoomToRegion()
        drawPolyline()
    }

    // MARK: - Public Functions
    public func setLocationData(data: LocationData) {
        locationData = data
    }
    
    // MARK: - Private Functions
    private func initializeMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
    }
    
    private func zoomToRegion() {
        if locationData.locationArray.count > 2 {
            let averageIndexPosition: Int = locationData.locationArray.count / 2
            let averageLocation = locationData.locationArray[averageIndexPosition]
            let location = CLLocationCoordinate2D(latitude: averageLocation.coordinate.latitude, longitude: averageLocation.coordinate.longitude)
            let region = MKCoordinateRegionMakeWithDistance(location, 10000, 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func drawPolyline() {
        var locationPoints = [CLLocationCoordinate2D]()
        for points in locationData.locationArray {
            locationPoints.append(points.coordinate)
        }
        let polyline = MKPolyline(coordinates: locationPoints, count: locationPoints.count)
        mapView.add(polyline)
    }
    
    private func getDescriptionString() -> String {
        return "Initial Date: \(infoData.initialDate)\nFinal Date: \(infoData.finalDate)\nAverage Speed: \(infoData.averageSpeedString)\nDistance: \(infoData.distance)\nInitial Altitude: \(infoData.initialAltitude)\nAverage Altitude: \(infoData.averageAltitude)"
    }
    
    // MARK: - MoreInfoCardView Logical
    private func setInitialStatusMoreInfoCardView() {
        moreInfoRouteCardView.delegate = self
        moreInfoRouteCardView.setTitle(text: locationData.routeName.capitalized)
        moreInfoRouteCardView.setDescription(text: getDescriptionString())
        moreInfoRouteInfoCardIsExpandMode = false
        constraintHeightMoreInfoCardView.constant = mainScreenBounds.height / 3
        constraintTopMoreInfoCardView.constant = mainScreenBounds.height
    }
    
    private func setHidePositionMoreInfoCardView() {
        moreInfoRouteInfoCardIsExpandMode = false
        barButtonExpandInfoCard.title = "Show"
        UIView.animate(withDuration: 0.6) {
            self.constraintTopMoreInfoCardView.constant = self.mainScreenBounds.height
            self.view.layoutIfNeeded()
        }
    }
    
    private func setShowPositionMoreInfoCardView() {
        moreInfoRouteInfoCardIsExpandMode = true
        barButtonExpandInfoCard.title = "Hide"
        UIView.animate(withDuration: 0.6) {
            self.constraintTopMoreInfoCardView.constant = self.mainScreenBounds.height / 2
            self.view.layoutIfNeeded()
        }
    }
    
    private func showOrHideMoreInfoCardView() {
        if !moreInfoRouteInfoCardIsExpandMode {
            setShowPositionMoreInfoCardView()
        } else {
            setHidePositionMoreInfoCardView()
        }
    }
    
    // MARK: - IBActions
    @IBAction func moreInfoBarButtonPressed(_ sender: UIBarButtonItem) {
        showOrHideMoreInfoCardView()
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
    
    // MARK: - MoreInfoRouteCardViewDelegate
    func moreInfoRouteCardViewTapped(view: MoreInfoRouteCardView) {
        showOrHideMoreInfoCardView()
    }
}
