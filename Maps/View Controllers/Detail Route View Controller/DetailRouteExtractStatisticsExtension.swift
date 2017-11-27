//
//  DetailRouteExtractStatisticsExtension.swift
//  Maps
//
//  Created by Alex on 26/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

extension DetailRouteViewController {
    
    internal func extractAllDetailStatisticsData() {
        extractAverageSpeed()
        extractDistance()
        extractAltitude()
        extractDate()
    }
    
    private func extractAverageSpeed() {
        if locationData.locationArray.count > 1 {
            var speedArray = [Double]()
            for locations in locationData.locationArray {
                speedArray.append(locations.speed)
            }
            let averageSpeed: Double = speedArray.average
            let kph = averageSpeed * 3.6
            let stringFormat = String(format: "%.01f", kph)
            infoData.averageSpeedString = "\(stringFormat) km/h"
        }
    }
    
    private func extractDistance() {
        if locationData.locationArray.count > 1 {
            let firstCoordinate = locationData.locationArray.first
            let lastCoordinate = locationData.locationArray.last
            let distanceInMeters = firstCoordinate?.distance(from: lastCoordinate!)
            let stringFormat = String(format: "%.0f", distanceInMeters!)
            infoData.distance = "\(stringFormat) m"
        }
    }
    
    private func extractAltitude() {
        if locationData.locationArray.count > 1 {
            var altitudeArray = [Double]()
            for locations in locationData.locationArray {
                altitudeArray.append(locations.altitude)
            }
            let averageAltitude: Double = altitudeArray.average
            infoData.averageAltitude = "\(String(format: "%.01f", averageAltitude)) m"
            
            if let firstAltitude: Double = locationData.locationArray.first?.altitude {
                infoData.initialAltitude = "\(String(format: "%.01f", firstAltitude)) m"
            }
        }
    }
    
    private func extractDate() {
        if locationData.locationArray.count > 1 {
            if let initialDate: Date = locationData.locationArray.first?.timestamp {
                infoData.initialDate = "\(initialDate.dayWithoutHours) - \(initialDate.hoursAndMinutes)"
            }
            
            if let finalDate: Date = locationData.locationArray.last?.timestamp {
                infoData.finalDate = "\(finalDate.dayWithoutHours) - \(finalDate.hoursAndMinutes)"
            }
        }
    }
}

