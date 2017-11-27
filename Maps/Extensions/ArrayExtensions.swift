//
//  ArrayExtensions.swift
//  Maps
//
//  Created by Alex on 26/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

extension Collection where Iterator.Element == Int, Index == Int {
    
    var average: Double {
        return isEmpty ? 0 : Double(reduce(0, +)) / Double(endIndex-startIndex)
    }
}

extension Array where Element: FloatingPoint {
    
    var total: Element {
        return reduce(0, +)
    }

    var average: Element {
        return isEmpty ? 0 : total / Element(count)
    }
}
