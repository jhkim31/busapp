//
//  StationInfo.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import Foundation



struct StationInfo: Codable, Identifiable{
	var id = UUID()
	var coordinate: coordinateStruct
	var mobileNo: String
	var stationId: String
	var stationName: String
	var districtCd: String
	var regionName: String
	var throughRouteList: [throughRouteStruct]
}

struct throughRouteStruct : Codable, Hashable ,Identifiable, Equatable{
	static func == (lhs: throughRouteStruct, rhs: throughRouteStruct) -> Bool {
		lhs.routeId == rhs.routeId
	}
	
	func hash(into hasher: inout Hasher) {
	  hasher.combine(routeId)
	}
	
	var id = UUID()
	var routeId: String
	var routeName: String
	var staOrder: String
	var predictTime1: String?
	var predictTime2: String?
	var locationNo1: String?
	var locationNo2: String?
}

struct coordinateStruct: Codable {
	var latitude: String
	var longitude: String
}

