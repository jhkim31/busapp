//
//  Locationmanager.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/29.
//

import Foundation
import CoreLocation

class LocationManager2: NSObject, ObservableObject {
	private let locationmanager = CLLocationManager()
	
	@Published var location: CLLocation?
	
	override init() {
		super.init()
		
		locationmanager.desiredAccuracy = kCLLocationAccuracyBest
		locationmanager.distanceFilter = kCLDistanceFilterNone
		locationmanager.requestAlwaysAuthorization()
		locationmanager.startUpdatingLocation()
		locationmanager.delegate = self
		
	}
}

extension LocationManager2: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		
		DispatchQueue.main.async {
			self.location = location
		}
	}
}
