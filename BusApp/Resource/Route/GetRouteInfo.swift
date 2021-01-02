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
	@Published var isload:Int = 0
	
	// 0 : 초기화
	// 1 : 정상 get
	// 2 : 노선 리스트 못받음
	
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
				print("ERROR")
				return
			}
			// Http 통신이 성공했을 경우, php나 서버에서 echo로 찍어줬을 때 받는 방법
			guard let returnStr = String(data: data!, encoding: .utf8) else {
				return
			}
			//			print(returnStr)
			//			print(type(of: returnStr))
			self.stringJsonData = returnStr
			print(self.stringJsonData)
			
			self.decodeJson(jsonData: self.stringJsonData)
			
		})
		// 실행
		task.resume()
		
	}
	func decodeJson(jsonData: String) {
		print(self.stringJsonData)
		print("decoding")
		
		let decoder = JSONDecoder()
		let stringJsonDatas = jsonData.data(using: .utf8)
		print("11")
		if let data = stringJsonDatas, let myData = try? decoder.decode(result_Header.self, from: data){
			print("head")
			print(myData)
			if myData.resultHeader.resultCode == "0"{
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
						self.isload = 1
					}
				}
			} else {
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body.self, from: data){
					print("body2")
					DispatchQueue.main.async {
						self.isload = 2
					}
				}
			}
		}
	}
	func getDataFromServer(routeId: String) {
		let url = "http://192.168.0.10:5000/getRouteInfo?routeId=\(routeId)"
		print(url)
		self.getHttpRequest(url: url)
	}
}
