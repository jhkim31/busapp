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
	@Published var isload:Int = -1
	
	// -1 : 초기화
	// 0 : 정상 get
	// 1 : operationInfo 받지 못함
	// 2 : operationInfo는 받고, 정류장 리스트를 받지 못함
	
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
				self.isload = 9
				self.errMsg = "알 수 없는 에러입니다."
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
			
			self.decodeJson(jsonData: self.stringJsonData)
			
		})
		// 실행
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
			} else if myHead.resultHeader.resultCode == "1" || myHead.resultHeader.resultCode == "2"  {
				DispatchQueue.main.async {
					self.isload = 1
					self.resultCode = myHead.resultHeader.resultCode
					self.errMsg = myHead.resultHeader.resultMsg
				}
			} else if myHead.resultHeader.resultCode == "3" || myHead.resultHeader.resultCode == "4" {
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
					DispatchQueue.main.async {
						self.routeInfoData.operationInfo = operationInfoStruct
						self.routeInfoData.routeId = myData.resultBody.routeId
						self.routeInfoData.routeName = myData.resultBody.routeName
						self.routeInfoData.districtCd = myData.resultBody.districtCd
						self.isload = 2
						self.resultCode = myHead.resultHeader.resultCode
						self.errMsg = myHead.resultHeader.resultMsg
					}
				}
			} else {
				DispatchQueue.main.async {
					self.isload = 9
					self.resultCode = myHead.resultHeader.resultCode
					self.errMsg = myHead.resultHeader.resultMsg
				}
			}
		}
	}
	func getDataFromServer(routeId: String) {
		let url = "http://\(config.host)/getRouteInfo?routeId=\(routeId)"
		print(url)
		self.getHttpRequest(url: url)
	}
}
