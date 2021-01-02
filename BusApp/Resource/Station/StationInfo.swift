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

struct throughRouteStruct : Codable, Hashable ,Identifiable{
	var id = UUID()
	var routeId: String
	var routeName: String
	
}

struct coordinateStruct: Codable {
	var latitude: String
	var longitude: String
}


var stationLists:[StationInfo] = [StationInfo(coordinate: coordinateStruct(latitude: "37.4182667", longitude: "127.2761667"), mobileNo: "38553", stationId: "234001177", stationName: "금강펜테리움아파트", districtCd: "2", regionName: "광주", throughRouteList: [])]


