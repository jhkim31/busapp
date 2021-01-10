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
		lhs.mobileNo == rhs.mobileNo && lhs.stationId == rhs.stationId
	}
	
	let id = UUID()
	var coordinate:CLLocationCoordinate2D 
	var stationName: String = ""
	var stationId: String = ""
	var mobileNo: String = ""
	var annotationIndex: Int?
	var showName: Bool = false
}



