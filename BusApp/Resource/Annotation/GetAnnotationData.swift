//
//  makeMapAnnotation.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/30.
//

import Foundation
import MapKit

class GetAnnotationData: ObservableObject {
	var stringJsonData:String = ""
	@Published var myAnnotation: [MyAnnotation] = []
	@Published var isload = -1
	// -1 : 초기화
	// 0 : 정상 호출
	// 9 : 알 수 없는 오류
	
	struct result_Header : Codable{
		var resultHeader: resultHeader
	}
	struct result_Body: Codable {
		var resultBody: jsonDataStruct
	}
	
	struct resultHeader : Codable {
		var resultCode: String
		var resultMsg: String
	}
	
	struct jsonDataStruct : Codable{
		var nearlyStationList: [stationInfo]
	}
	
	struct stationInfo: Codable {
		var centerYn: String
		var distance: String
		var mobileNo : String
		var regionName: String
		var stationId: String
		var stationName: String
		var x: String
		var y: String
		var districtCd: String
	}
	func getHttpRequest(url: String){
		let url = URL(string: url)
		let task = URLSession.shared.dataTask(with: url!, completionHandler: {
			(data, response, error) -> Void in
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
				DispatchQueue.main.async { self.isload = 9 }
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
			if (myHead.resultHeader.resultCode == "0" ) {
				if let data = stringJsonDatas, let myData = try? decoder.decode(result_Body.self, from: data){
					var index = 0
					for item in myData.resultBody.nearlyStationList {
						let tmp: MyAnnotation = MyAnnotation(
							coordinate: CLLocationCoordinate2D(latitude: Double(item.y) ?? 0, longitude: Double(item.x) ?? 0),
							stationName: item.stationName,
							stationId: item.stationId,
							mobileNo: item.mobileNo,
							annotationIndex: index,
							districtCd: item.districtCd
						)
						DispatchQueue.main.async {
							self.myAnnotation.append(tmp)
							self.isload = 0
						}
						index += 1
					}
				}
			} else {
				DispatchQueue.main.async {
					self.isload = 1
				}
			}
		}
	}
	func getDataFromServer(latitude: String, longitude: String) {
		let url = "http://\(config.host)/getNearlyStationList?latitude=\(latitude)&longitude=\(longitude)"
		print(url)
		self.getHttpRequest(url: url)
	}
	
	func showName(index: Int){
		for i in 0...(myAnnotation.count - 1) {
			if (index == i){
				myAnnotation[i].showName = true
			}
				myAnnotation[i].showName = false
		}
	}
}
