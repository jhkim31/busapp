//
//  GetStationInfo.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/01.
//

import Foundation
import MapKit


class GetRouteInfo: ObservableObject {
	
	var stringJsonData:String = ""
	@Published var routeInfoData = RouteInfo(
		routeId: "nil",
		routeName: "nil",
		operationInfo: OperationInfoStruct(
			downFirstTime: "nil",
			downLastTime: "nil",
			endMobileNo: "nil",
			endStationId: "nil",
			endStationName: "nil",
			nPeekAlloc: "nil",
			peekAlloc: "nil",
			startMobileNo: "nil",
			startStationId: "nil",
			startStationName: "nil",
			upFirstTime: "nil",
			upLastTime: "nil"
		),
		districtCd: "nil",
		stationLists: []
	)
	@Published var RunningBus: Int = 0
	@Published var isload:Int = -1
	
	// -1 : 초기화
	// 0 : 정상 get
	// 1 : operationInfo 받지 못함
	// 2 : operationInfo는 받고, 정류장 리스트를 받지 못함
	@Published var currentLocationDataLoad = -1
	
	@Published var errMsg: String = ""
	@Published var resultCode: String = ""
	
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
	struct OperationInfo_tmp : Codable{
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
	
	struct resultBody : Codable{
		var routeId: String
		var routeName: String
		var operationInfo: OperationInfo_tmp
		var districtCd: String
		var stationLists: [stationListStruct_tmp]
	}
	
	struct stationListStruct_tmp : Codable{
		var districtCd: String
		var mobileNo: String
		var stationId: String
		var stationName: String
		var stationSeq:String
		var turnYn:String
	}
	
	
	func getHttpRequest(url: String){
		let url = URL(string: url)
		let task = URLSession.shared.dataTask(with: url!, completionHandler: {
			(data, response, error) -> Void in
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
				DispatchQueue.main.async { self.isload = 1 }
				print("ERROR")
				return
			}
			guard let returnStr = String(data: data!, encoding: .utf8) else {
				return
			}
			self.stringJsonData = returnStr
			
			self.decodeJson(jsonData: self.stringJsonData)
		})
		task.resume()
		
	}
	func decodeJson(jsonData: String) {
		let decoder = JSONDecoder()
		let stringJsonDatas = jsonData.data(using: .utf8)
		if let data = stringJsonDatas, let myHead = try? decoder.decode(result_Header.self, from: data){
			print("resultCode = \(myHead.resultHeader.resultCode), resultMsg = \(myHead.resultHeader.resultMsg)")
			
			if myHead.resultHeader.resultCode == "0"{
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body.self, from: data){
					
					let operationInfoStruct = OperationInfoStruct(
						downFirstTime: myData.resultBody.operationInfo.downLastTime,
						downLastTime: myData.resultBody.operationInfo.downLastTime,
						endMobileNo: myData.resultBody.operationInfo.endMobileNo,
						endStationId: myData.resultBody.operationInfo.endStationId,
						endStationName: myData.resultBody.operationInfo.endStationName,
						nPeekAlloc: myData.resultBody.operationInfo.nPeekAlloc,
						peekAlloc: myData.resultBody.operationInfo.peekAlloc,
						startMobileNo: myData.resultBody.operationInfo.startMobileNo,
						startStationId: myData.resultBody.operationInfo.startStationId,
						startStationName: myData.resultBody.operationInfo.startStationName,
						upFirstTime: myData.resultBody.operationInfo.upFirstTime,
						upLastTime: myData.resultBody.operationInfo.upLastTime
					)
					var tmpList:[stationListStruct] = []
					for item in myData.resultBody.stationLists{
						let stationListStruct_tmp = stationListStruct(
							districtCd: item.districtCd,
							mobileNo: item.mobileNo,
							stationId: item.stationId,
							stationName: item.stationName,
							stationSeq: item.stationSeq,
							turnYn: item.turnYn
						)
						tmpList.append(stationListStruct_tmp)
					}
					DispatchQueue.main.async {
						self.routeInfoData.operationInfo = operationInfoStruct
						self.routeInfoData.routeId = myData.resultBody.routeId
						self.routeInfoData.routeName = myData.resultBody.routeName
						self.routeInfoData.districtCd = myData.resultBody.districtCd
						self.routeInfoData.stationLists = tmpList
						self.isload = 0
					}
				}
			} else {
				DispatchQueue.main.async {
					self.isload = 1
				}
			}
		}
	}
	
	func getHttpRequest2(url: String){
		let url = URL(string: url)
		let task = URLSession.shared.dataTask(with: url!, completionHandler: {
			(data, response, error) -> Void in
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
				DispatchQueue.main.async {
					self.currentLocationDataLoad = 9
				}
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
	
	func decodeJson2(jsonData: String){
		let decoder = JSONDecoder()
		let stringJsonDatas = jsonData.data(using: .utf8)
		struct result_Body2 : Codable {
			var resultBody: currentLocationList
		}
		
		struct currentLocationList : Codable{
			var busLocationList: [currentLocation]
		}
		
		struct currentLocation : Codable{
			var stationId: String
			var stationSeq: String
		}
		if let data = stringJsonDatas, let myHead = try? decoder.decode(result_Header.self, from: data){
			if myHead.resultHeader.resultCode == "0"{
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body2.self, from: data){
					DispatchQueue.main.async { self.RunningBus = myData.resultBody.busLocationList.count }
					myData.resultBody.busLocationList.forEach { item in
						if let i = (self.routeInfoData.stationLists.firstIndex(of: stationListStruct(districtCd: "", mobileNo: "", stationId: item.stationId, stationName: "", stationSeq: item.stationSeq, turnYn: ""))){
							DispatchQueue.main.async {
								self.currentLocationDataLoad = 0
								self.routeInfoData.stationLists[i + 1].currentLocation = true
							}
							
						}
					}
				}
			} else {
				DispatchQueue.main.async {
					self.currentLocationDataLoad = 1
				}
			}
		}
	}
	
	
	func getDataFromServer(routeId: String) {
		let url = "http://\(config.host)/getRouteInfo?routeId=\(routeId)"
		print(url)
		self.getHttpRequest(url: url)
	}
	
	func getCurrentLocationData(routeId: String) {
		let url = "http://\(config.host)/getCurrentLocation?routeId=\(routeId)"
		print(url)
		self.getHttpRequest2(url: url)
	}
}
