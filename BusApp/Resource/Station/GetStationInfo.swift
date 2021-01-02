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
					print("body")
					print(myData.resultBody)
					
					let coordinate_tmp = coordinateStruct(
						latitude: myData.resultBody.coordinate.latitude,
						longitude: myData.resultBody.coordinate.longitude
					)
					
					var throughRouteList_tmp: [throughRouteStruct] = []
					for item in myData.resultBody.throughRouteList {
						let tmp = throughRouteStruct(routeId: item.routeId, routeName: item.routeName)
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
						self.isload = 1
						print(self.isload)
					}
				}
			} else {
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body.self, from: data){
					let coordinate_tmp = coordinateStruct(
						latitude: myData.resultBody.coordinate.latitude,
						longitude: myData.resultBody.coordinate.longitude
					)
					DispatchQueue.main.async {
						self.stationInfoData.coordinate = coordinate_tmp
						self.stationInfoData.stationId = myData.resultBody.stationId
						self.stationInfoData.stationName = myData.resultBody.stationName
						self.stationInfoData.mobileNo = myData.resultBody.mobileNo
						self.stationInfoData.districtCd = myData.resultBody.districtCd
						self.stationInfoData.regionName = myData.resultBody.regionName
						self.isload = 2
						print(self.isload)
					}
				}
			}
		}
	}
	func getDataFromServer(mobileNo: String, stationId: String) {
		let url = "http://localhost:5000/getStationInfo?mobileNo=\(mobileNo)&stationId=\(stationId)"
		print(url)
		self.getHttpRequest(url: url)
	}
}
