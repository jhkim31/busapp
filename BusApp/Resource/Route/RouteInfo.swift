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
	var districtCd: String
	var mobileNo: String
	var stationId: String
	var stationName: String
	var stationSeq:String
	var turnYn:String
}
