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
			if getStationInfo.isload == 1 {
				VStack{
					Text(getStationInfo.stationInfoData.stationName)
					Text(getStationInfo.stationInfoData.stationId)
					Text(getStationInfo.stationInfoData.mobileNo)
					Text(getStationInfo.stationInfoData.districtCd)
					ForEach(getStationInfo.stationInfoData.throughRouteList, id: \.self){item in
						HStack{
							Text(item.routeName)
							Text(item.routeId)
						}
					}
				}
			} else if getStationInfo.isload == 2 {
				Text(getStationInfo.stationInfoData.stationName)
				Text(getStationInfo.stationInfoData.stationId)
				Text(getStationInfo.stationInfoData.mobileNo)
				Text(getStationInfo.stationInfoData.districtCd)
				Text("노선 정보를 받아오지 못했습니다. (서울 / 인천)")
			}
		}
		.onAppear {
			getData()
		}
	}
	private func getData(){
		getStationInfo.getDataFromServer(mobileNo: mobileNo, stationId: stationId)
	}
}

struct StationDetailView_Previews: PreviewProvider {
	static var previews: some View {
		StationDetailView(mobileNo: "38553", stationId: "234001177")
	}
}
