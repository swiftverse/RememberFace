//
//  LocationFetcher.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 18/01/22.
//

import Foundation

import CoreLocation
import MapKit

class LocationFetcher: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion()
    
    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
        locations.last.map {
                   region = MKCoordinateRegion(
                       center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                       span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                   )
               }
    }
}
