//
//  RoutesTableViewCell.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class RoutesTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet private var containerView: CustomView!
    @IBOutlet private var labelTitle: UILabel!
    @IBOutlet private var imageViewMap: UIImageView!
    @IBOutlet private var imageViewForward: UIImageView! {
        didSet {
            imageViewForward.image = UIImage(named: "forward")?.withRenderingMode(.alwaysTemplate)
            imageViewForward.tintColor = .white
        }
    }
    
    @IBOutlet private var textViewDescription: UITextView! {
        didSet {
            textViewDescription.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Public Functions
    public class func getNibName() -> String {
        return "RoutesTableViewCell"
    }
    
    public func setCell(data: LocationData) {
        labelTitle.text = data.routeName.capitalized
        setDescriptionText(data: data.locationArray)
        
        if imageViewMap.image == nil {
            setMapSnapshotImage(data: data.locationArray)
        }
    }
    
    // MARK: - Private Functions
    private func setMapSnapshotImage(data: [CLLocation]) {
        let mapSnapshotOptions = MKMapSnapshotOptions()
        
        if !data.isEmpty && data.count > 1 {
            let location = CLLocationCoordinate2DMake(data.first!.coordinate.latitude, data.last!.coordinate.longitude)
            let region = MKCoordinateRegionMakeWithDistance(location, 10000, 10000)
            
            mapSnapshotOptions.region = region
            mapSnapshotOptions.scale = UIScreen.main.scale
            mapSnapshotOptions.showsBuildings = true
            mapSnapshotOptions.showsPointsOfInterest = true
            
            let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
            
            DispatchQueue.global().async {
                snapShotter.start() { snapshot, error in guard let snapshot = snapshot else { return }
                    DispatchQueue.main.async {
                        self.imageViewMap.image = snapshot.image
                    }
                }
            }
        }
    }
    
    private func setDescriptionText(data: [CLLocation]) {
        if !data.isEmpty && data.count > 1 {
            let firstLocation: CLLocation = data.first!
            let lastLocation: CLLocation = data.last!
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(firstLocation) { (placemarks, error) in
                if let placemark = placemarks?[0] {
                    if let administrativeArea = placemark.administrativeArea, let locality = placemark.locality, let subLocality = placemark.subLocality {
                        self.textViewDescription.text = "\(firstLocation.timestamp.dayWithoutHours) (\(firstLocation.timestamp.hoursAndMinutes) - \(lastLocation.timestamp.hoursAndMinutes))\n\(administrativeArea) - \(locality)\n\(subLocality)"
                    }
                }
            }
        }
    }
}
