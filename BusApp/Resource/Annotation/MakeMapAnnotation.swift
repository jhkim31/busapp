//
//  makeMapAnnotation.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/30.
//

import Foundation
import MapKit

class MakeMapAnnotation: ObservableObject {
	var stringJsonData:String = ""
	@Published var myAnnotation: [MyAnnotation] = []
	
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
		print(jsonData)
		let decoder = JSONDecoder()
		let stringJsonData = jsonData.data(using: .utf8)
		if let data = stringJsonData, let myData = try? decoder.decode(jsonDataStruct.self, from: data){
			for item in myData.nearlyStationList {
				let tmp: MyAnnotation = MyAnnotation(
					coordinate: CLLocationCoordinate2D(latitude: Double(item.y) ?? 0, longitude: Double(item.x) ?? 0),
					stationName: item.stationName,
					stationId: item.stationId,
					mobileNo: item.mobileNo
				)
				DispatchQueue.main.async {
					self.myAnnotation.append(tmp)
				}
			}
		}
	}
	func getDataFromServer(latitude: String, longitude: String) {
		let url = "http://192.168.0.10:5000/getNearlyStationList?latitude=\(latitude)&longitude=\(longitude)"
		print(url)
		self.getHttpRequest(url: url)
	}
}
