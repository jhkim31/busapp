//
//  StationInfo.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import Foundation


struct StationInfo: Identifiable{
	var id:UUID = UUID()
	var stationId: String
	var stationName: String
	var coordinate: Coordinate
	var throughRouteId: [String]
}

var stationLists:[StationInfo] = [StationInfo(stationId: "234001177", stationName: "금강펜테리움아파트", coordinate: Coordinate(latitude: "37.4182667", longitude: "127.2761667"), throughRouteId: []), StationInfo(stationId: "234000180", stationName: "브라운스톤아파트", coordinate: Coordinate(latitude: "37.4168167", longitude: "127.2732167"),  throughRouteId: [])]


