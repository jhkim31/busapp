//
//  StationAndRouteInfo.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import Foundation

struct StationAndRouteInfo :Identifiable{
	var id: UUID = UUID()
	var stationId: String
	var stationName: String
	var routeId: String
	var routeName: String
	
}

var stationAndRouteLists = [StationAndRouteInfo(stationId: "123123", stationName: "금강 펜테리움", routeId: "2-1123123", routeName: "2-1"), StationAndRouteInfo(stationId: "123123", stationName: "금강 펜테리움", routeId: "35-351223", routeName: "35-3")]
