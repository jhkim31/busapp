//
//  StationInfo.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import Foundation



struct StationInfo: Codable, Identifiable{		// 정류장의 정보 구조체
	var id = UUID()								// Identifiable를 위한 필드
	var coordinate: coordinateStruct			// 정류장의 좌표
	var mobileNo: String						// 정류장 검색을 위한 5자리 번호
	var stationId: String						// 정류장의 ID
	var stationName: String						// 정류장 이름
	var districtCd: String						// 관할 지역 1 : 서울, 2 : 경기, 3 : 인천 2만 사용 가능함
	var regionName: String						// 지역 이름
	var throughRouteList: [throughRouteStruct]	// 통과하는 노선 리스트
}

struct throughRouteStruct : Codable, Hashable ,Identifiable, Equatable{			//통과하는 노선의 구조체
	static func == (lhs: throughRouteStruct, rhs: throughRouteStruct) -> Bool {	// Equatable 채택에 필요, 나중 노선의 시간값을 적용하는데 필요함
		lhs.routeId == rhs.routeId
	}
	
	func hash(into hasher: inout Hasher) {										// hashable를 위해 필요
	  hasher.combine(routeId)
	}
	
	var id = UUID()																// Identifiable를 위한 필드
	var routeId: String															// 노선 ID
	var routeName: String														// 노선 이름
	var staOrder: String														// 현재 정거장이 이 노선에서 몇번째 정거장인지
	var predictTime1: String?													// 현재 이 정류장까지 얼마나 남았나 하는 정보 : 가장 빠른 버스의 시간
	var predictTime2: String?													// 현재 이 정류장까지 얼마나 남았나 하는 정보 : 두번째로 빠른 버스의 시간
	var locationNo1: String?													// 현재 이 정류장까지 얼마나 남았나 하는 정보 : 가장 빠른 버스의 남은 정거장 수
	var locationNo2: String?													// 현재 이 정류장까지 얼마나 남았나 하는 정보 : 두번째로 빠른 버스의 남은 정거장 수
}

struct coordinateStruct: Codable {												//좌표 구조체
	var latitude: String														// 위도
	var longitude: String														// 경도
}
