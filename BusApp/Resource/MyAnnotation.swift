//
//  MapAnnotation.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/30.
//

import Foundation
import MapKit

struct MyAnnotation : Identifiable, Equatable{
	static func == (lhs: MyAnnotation, rhs: MyAnnotation) -> Bool {
		lhs.mobileNo == rhs.mobileNo
	}
	
	let id = UUID()
	
	var imageRoute: String = "busMark"
	var coordinate:CLLocationCoordinate2D 
	var stationName: String = ""
	var stationId: String = ""
	var mobileNo: String = ""
	var showStationName: Bool = false
}



