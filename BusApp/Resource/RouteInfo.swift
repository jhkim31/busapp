//
//  RouteInfo.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import Foundation

struct Coordinate {
	var latitude: String
	var longitude: String
}

struct OperationInfo {
	
}

struct RouteInfo : Identifiable{
	var id: UUID = UUID()
	var routeId: String
	var routeName: String
//	var courseList: [Coordinate]
//	var stationIdList: [String]
//	var operationInfo: OperationInfo
}



var routeLists:[RouteInfo] = [RouteInfo(routeId: "123141", routeName: "2-1"), RouteInfo(routeId: "1231412", routeName: "35-3")]
