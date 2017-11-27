//
//  DateExtensions.swift
//  Maps
//
//  Created by Alex on 26/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

extension Date {
    struct Formatter {
        static let dayWithoutHours = DateFormatter(dateFormat: "dd/M/yyyy")
        static let hoursAndMinutes = DateFormatter(dateFormat: "H:mm")
    }
    
    var dayWithoutHours: String {
        return Formatter.dayWithoutHours.string(from: self)
    }
    
    var hoursAndMinutes: String {
        return Formatter.hoursAndMinutes.string(from: self)
    }
}
