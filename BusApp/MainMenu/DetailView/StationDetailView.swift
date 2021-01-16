//
//  StationDetailView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct StationDetailView: View {
	@ObservedObject var getStationInfo = GetStationInfo()
	var mobileNo: String
	var stationId : String
	var body: some View {
		VStack{
			if getStationInfo.informationLoad == 0 {
				VStack{
					Text(getStationInfo.stationInfoData.stationName)
					Text(getStationInfo.stationInfoData.stationId)
					Text(getStationInfo.stationInfoData.mobileNo)
					Text(getStationInfo.stationInfoData.districtCd)
					Button(action: {
						getStationInfo.arrivalInfoLoad = -1
						getData2()
					}) {
						Image(systemName: "arrow.clockwise")
					}
					ScrollView{
						ForEach(getStationInfo.stationInfoData.throughRouteList, id: \.self){item in
							NavigationLink(destination: RouteDetailView(routeId: item.routeId)){
								HStack{
									Text(item.routeName)
									Text(item.routeId)
									Text(item.staOrder)
									Spacer()
									VStack(alignment: .trailing){
										if (getStationInfo.arrivalInfoLoad == 0){
											if let locationNo1 = item.locationNo1, let locationNo2 = item.locationNo2,
											   let predictTime1 = item.predictTime1, let predictTime2 = item.predictTime2{
												Text("\(locationNo1) 정거장 전 | \(predictTime1) 분 후 도착")
													.foregroundColor(.blue)
												Text("\(locationNo2) 정거장 전 | \(predictTime2) 분 후 도착")
													.foregroundColor(.blue)
											} else {
												Text("도착 정보가 없습니다.")
													.foregroundColor(.yellow)
											}
										} else if (getStationInfo.arrivalInfoLoad == 1) {
											Text("도착 정보가 없습니다.")
												.foregroundColor(.red)
										} else {
											Text("로딩중")
										}
									}
									.frame(height: 40)
								}
							}
						}
					}
				}
				.onAppear { getData2() }
			} else if getStationInfo.informationLoad == 1 {						// 정류소 정보를 받지 못했을때
				VStack{
					Text(getStationInfo.resultCode)
					Text(getStationInfo.errMsg)
					Button(action: {
						getData()
					}) {
						HStack{
							Image(systemName: "arrow.clockwise")
							Text("다시 받아오기")
						}
					}
				}
			} else if getStationInfo.informationLoad == 2 {
				VStack{
					Text(getStationInfo.stationInfoData.stationName)
					Text(getStationInfo.stationInfoData.stationId)
					Text(getStationInfo.stationInfoData.mobileNo)
					Text(getStationInfo.stationInfoData.districtCd)
					Text(getStationInfo.resultCode)
					Text(getStationInfo.errMsg)
					Button(action: {
						getData()
					}) {
						HStack{
							Image(systemName: "arrow.clockwise")
							Text("다시 받아오기")
						}
					}
				}
			} else {
				Text("로딩중...")
			}
		}
		.onAppear {
			getData()
		}
	}
	private func getData(){
		getStationInfo.getDataFromServer1(mobileNo: mobileNo, stationId: stationId)
	}
	private func getData2(){
		getStationInfo.getDataFromServer2(stationId: stationId)
	}
}

struct StationDetailView_Previews: PreviewProvider {
	static var previews: some View {
		StationDetailView(mobileNo: "38553", stationId: "234001177")
	}
}
