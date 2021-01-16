import Foundation

struct OperationInfoStruct : Codable{
	var downFirstTime: String
	var downLastTime: String
	var endMobileNo: String
	var endStationId: String
	var endStationName: String
	var nPeekAlloc: String
	var peekAlloc: String
	var startMobileNo: String
	var startStationId: String
	var startStationName: String
	var upFirstTime: String
	var upLastTime: String
}

struct RouteInfo : Codable, Identifiable{
	var id: UUID = UUID()
	
	var routeId: String
	var routeName: String
	var operationInfo: OperationInfoStruct
	var districtCd: String
	var stationLists: [stationListStruct]
}

struct stationListStruct : Codable, Hashable{
	
	func hash(into hasher: inout Hasher) {										// hashable를 위해 필요
	  hasher.combine(stationId )
	}
	
	static func == (lhs: stationListStruct, rhs: stationListStruct) -> Bool {	// Equatable 채택에 필요, 나중 노선의 시간값을 적용하는데 필요함
		lhs.stationSeq == rhs.stationSeq
	}
	
	var districtCd: String
	var mobileNo: String
	var stationId: String
	var stationName: String
	var stationSeq:String
	var turnYn:String
	var currentLocation: Bool = false
}
