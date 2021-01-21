//
//  MapAnnotation.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/30.
//

import Foundation
import MapKit

struct MyAnnotation : Identifiable, Equatable{				//정류장을 지도에 표시하기 위한 구조체
	static func == (lhs: MyAnnotation, rhs: MyAnnotation) -> Bool {
		lhs.mobileNo == rhs.mobileNo && lhs.stationId == rhs.stationId
	}
	
	let id = UUID()								// Identifiable를 위한 필드
	var coordinate:CLLocationCoordinate2D 		// 정류장의 좌표
	var stationName: String						// 정류장 이름
	var stationId: String						// 정류장 ID
	var mobileNo: String						// 정류장의 5자리번호 (검색을 위해 필요함)
	var annotationIndex: Int?					// 인덱스번호 (사용 안함)
	var showName: Bool = false					// 이름을 나타내는 Bool 필드 (사용 안함)
	var districtCd: String
}



