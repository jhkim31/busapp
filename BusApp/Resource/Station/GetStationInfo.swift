//
//  GetStationInfo.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/01.
//

import Foundation
import MapKit


class GetStationInfo: ObservableObject {
	
	var stringJsonData:String = ""
	@Published var stationInfoData = StationInfo(
		coordinate: coordinateStruct(latitude: "nil", longitude: "nil"),
		mobileNo: "nil",
		stationId: "nil",
		stationName: "nil",
		districtCd: "ni",
		regionName: "nil",
		throughRouteList: []
	)
	@Published var informationLoad:Int = -1
	// -1 : 초기화
	// 0 : 정상
	// 1 : 에러
	@Published var arrivalInfoLoad:Int = -1
	
	struct result_Header : Codable{
		var resultHeader: resultHeader
	}
	struct result_Body: Codable {
		var resultBody: resultBody
	}
	
	struct resultHeader : Codable {
		var resultCode: String
		var resultMsg: String
	}
	struct resultBody : Codable{
		var coordinate: coordinate_readJson
		var districtCd: String
		var mobileNo: String
		var regionName: String
		var stationId: String
		var stationName: String
		var throughRouteList: [throughRoute_readJson]
	}
	
	struct coordinate_readJson : Codable{
		var latitude: String
		var longitude: String
	}
	
	struct throughRoute_readJson : Codable{
		var routeId : String
		var routeName: String
		var staOrder: String
	}
	
	func getHttpRequest1(url: String){											//정류장 정보 얻는 Request (Id, 이름, mobileNo, districtCd,등 )
		let url = URL(string: url)
		let task = URLSession.shared.dataTask(with: url!, completionHandler: {
			(data, response, error) -> Void in
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
				DispatchQueue.main.async { self.informationLoad = 1 }
				print("ERROR")
				return
			}
			guard let returnStr = String(data: data!, encoding: .utf8) else {
				return
			}
			self.stringJsonData = returnStr
			self.decodeJson1(jsonData: self.stringJsonData)
		})
		task.resume()
	}
	
	func decodeJson1(jsonData: String) {
		let decoder = JSONDecoder()
		let stringJsonDatas = jsonData.data(using: .utf8)
		if let data = stringJsonDatas, let myHead = try? decoder.decode(result_Header.self, from: data){
			if myHead.resultHeader.resultCode == "0"{																//정상Code일때 진행
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body.self, from: data){		//
					print(myData)
					let coordinate_tmp = coordinateStruct(
						latitude: myData.resultBody.coordinate.latitude,
						longitude: myData.resultBody.coordinate.longitude
					)
					
					var throughRouteList_tmp: [throughRouteStruct] = []
					for item in myData.resultBody.throughRouteList {
						let tmp = throughRouteStruct(routeId: item.routeId, routeName: item.routeName, staOrder: item.staOrder)
						throughRouteList_tmp.append(tmp)
					}
					DispatchQueue.main.async {
						self.stationInfoData.coordinate = coordinate_tmp
						self.stationInfoData.throughRouteList = throughRouteList_tmp
						self.stationInfoData.stationId = myData.resultBody.stationId
						self.stationInfoData.stationName = myData.resultBody.stationName
						self.stationInfoData.mobileNo = myData.resultBody.mobileNo
						self.stationInfoData.districtCd = myData.resultBody.districtCd
						self.stationInfoData.regionName = myData.resultBody.regionName
						self.informationLoad = 0																			//informationLoad = 0
					}
				}
			} else {											//알 수 없는 오류
				DispatchQueue.main.async { self.informationLoad = 1 }
			}
		}
	}
	func getHttpRequest2(url: String){
		let url = URL(string: url)
		let task = URLSession.shared.dataTask(with: url!, completionHandler: {
			(data, response, error) -> Void in
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
				DispatchQueue.main.async { self.arrivalInfoLoad = 1 }
				print("ERROR")
				return
			}
			guard let returnStr = String(data: data!, encoding: .utf8) else {
				return
			}
			self.stringJsonData = returnStr
			self.decodeJson2(jsonData: self.stringJsonData)
		})
		task.resume()
	}
	func decodeJson2(jsonData: String) {
		let decoder = JSONDecoder()
		let stringJsonDatas = jsonData.data(using: .utf8)
		
		struct result_Body2: Codable {
			var resultBody: resultBody2
		}
		struct resultBody2 :Codable {
			var busArrivalList: [ArrivalData]
		}
		
		struct ArrivalData: Codable {
			var routeId:String
			var flag: String
			var locationNo1: String
			var locationNo2: String
			var predictTime1: String
			var predictTime2: String
		}
		
		if let data = stringJsonDatas, let myHead = try? decoder.decode(result_Header.self, from: data){
			if myHead.resultHeader.resultCode == "0"{
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body2.self, from: data){
					myData.resultBody.busArrivalList.forEach{item in
						if let a = (self.stationInfoData.throughRouteList.firstIndex(of: throughRouteStruct(routeId: item.routeId, routeName: "nil", staOrder: "nil"))) {
							DispatchQueue.main.async {
								self.stationInfoData.throughRouteList[a].locationNo1 = item.locationNo1
								self.stationInfoData.throughRouteList[a].locationNo2 = item.locationNo2
								self.stationInfoData.throughRouteList[a].predictTime1 = item.predictTime1
								self.stationInfoData.throughRouteList[a].predictTime2 = item.predictTime2
								self.arrivalInfoLoad = 0
							}
						}
					}
				}
			} else {
				DispatchQueue.main.async { self.arrivalInfoLoad = 1 }
			}
		}
	}
	func clear(){
		DispatchQueue.main.async {
			self.stationInfoData.stationName = ""
		}
	}
	func getDataFromServer1(mobileNo: String, stationId: String) {
		let url = "http://\(config.host)/getStationInfo?mobileNo=\(mobileNo)&stationId=\(stationId)"
		print("request url = \(url)")
		self.getHttpRequest1(url: url)
	}
	
	func getDataFromServer2(stationId: String) {
		let url = "http://\(config.host)/getArrivalInformation?stationId=\(stationId)"
		print("request url = \(url)")
		self.getHttpRequest2(url: url)
	}
}
