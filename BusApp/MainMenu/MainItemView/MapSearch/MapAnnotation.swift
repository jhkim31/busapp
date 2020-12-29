//
//  MapAnnotation.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/30.
//

import Foundation
import MapKit

struct MyAnnotation : Identifiable{
	let id = UUID()
	var coordinate: CLLocationCoordinate2D
	var imageRoute: String = "busMark"
	var description: String
	
}
