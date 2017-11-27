//
//  LocationData.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit
import CoreLocation

class LocationData: NSObject, NSCoding {
    let routeName: String
    let locationArray: [CLLocation]
    
    init(routeName: String, locationArray: [CLLocation]) {
        self.routeName = routeName
        self.locationArray = locationArray
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.routeName = (aDecoder.decodeObject(forKey: "routeName") as? String)!
        self.locationArray = (aDecoder.decodeObject(forKey: "locationArray") as? [CLLocation])!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(routeName, forKey: "routeName")
        aCoder.encode(locationArray, forKey: "locationArray")
    }
}
