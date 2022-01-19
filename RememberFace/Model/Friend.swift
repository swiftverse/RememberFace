//
//  Friend.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 16/01/22.
//

import Foundation
import UIKit
import SwiftUI
import MapKit


struct Friend: Codable, Comparable, Identifiable, Equatable {
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        lhs.picName < rhs.picName
    }
    var picName: String
   
    var id: UUID
    
    let longitude: Double
    let latitude: Double
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs: Friend, rhs: Friend) -> Bool {
        lhs.id == rhs.id
    }
}
