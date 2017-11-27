//
//  UserDefaultsHelper.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class UserDefaultsHelper: NSObject {
    
    static let userDefaults = UserDefaults.standard
    
    class func setLocations(array: [LocationData]) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: array)
        userDefaults.set(encodedData, forKey: "locations")
    }
    
    class func getLocations() -> [LocationData] {
        if let data = UserDefaults.standard.data(forKey: "locations"), let locations = NSKeyedUnarchiver.unarchiveObject(with: data) as? [LocationData] {
            return locations
        } else {
            return [LocationData]()
        }
    }
    
    class func hasLocations() -> Bool {
        return userDefaults.data(forKey: "locations") != nil
    }
    
}
