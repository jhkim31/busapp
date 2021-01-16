//
//  StationgetStationInfo_popupView.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/01.
//

import SwiftUI
import MapKit

struct StationInfoPopupView: View {
	@ObservedObject var getStationInfo_popup: GetStationInfo
	var stationId:String
	var mobileNo: String
	@Binding var popup: Bool
	var body: some View {
		VStack{
			HStack{
				Spacer()
				Button(action: {
					popup = false
				}) {
					Text("닫기")
				}
			}
			if getStationInfo_popup.informationLoad == 0 {
				NavigationLink(destination: StationDetailView(
								mobileNo: getStationInfo_popup.stationInfoData.mobileNo,
								stationId: getStationInfo_popup.stationInfoData.stationId)) {
					Text(getStationInfo_popup.stationInfoData.stationName)
				}
				
				Text(getStationInfo_popup.stationInfoData.stationId)
				Text(getStationInfo_popup.stationInfoData.mobileNo)
				ScrollView {
					ForEach(getStationInfo_popup.stationInfoData.throughRouteList, id: \.self) { item in
						NavigationLink(destination: RouteDetailView(routeId: item.routeId)) {
							HStack{
								Text(item.routeName)
								Text(item.routeId)
								Text(item.staOrder)
							}
						}
					}
				}
			} else if getStationInfo_popup.informationLoad == 1 {
				VStack{
					Text(getStationInfo_popup.stationInfoData.stationName)
					Text(getStationInfo_popup.stationInfoData.stationId)
					Text(getStationInfo_popup.stationInfoData.mobileNo)
					Text(getStationInfo_popup.resultCode)
					Text(getStationInfo_popup.errMsg)
				}
			} else if getStationInfo_popup.informationLoad == 2 {
				VStack{
					Text(getStationInfo_popup.resultCode)
					Text(getStationInfo_popup.errMsg)
				}
			} else {
				VStack{
					Text("로딩중...")
					Text(String(getStationInfo_popup.informationLoad))
				}
				
			}
			Spacer()
		}
		.onAppear { getData() }
		.frame(width: 400, height: 600)
		.background(Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255, opacity: 0.9))
	}
	private func getData(){
		getStationInfo_popup.getDataFromServer1(mobileNo: mobileNo, stationId: stationId)
	}
	//	private func getData2() {
	//		getStationInfo_popup.getDataFromServer2(stationId: stationId)
	//	}
}
//	private func getData(){
//		getStationInfo_popup.getDataFromServer(mobileNo: mobileNo, stationId: stationId)
//	}
//}
//struct StationgetStationInfo_popupView_Previews: PreviewProvider {
//	static var previews: some View {
//		StationgetStationInfo_popupView(popup: .constant(true), stationId: "234001177", mobileNo: "38553")
//	}
//}
