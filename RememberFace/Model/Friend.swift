//
//  Friend.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 16/01/22.
//

import Foundation
import UIKit
import SwiftUI


struct Friend: Codable, Comparable, Identifiable{
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        lhs.picName < rhs.picName
    }
    var picName: String
   
    var id: UUID
    
    let longitude: Double
    let latitude: Double
}
