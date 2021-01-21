//
//  RouteDetailView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct RouteDetailView: View {
	@ObservedObject var getRouteInfo = GetRouteInfo()
	var busif: Bool = true
	var routeId: String
	var body: some View {
		VStack{
			if getRouteInfo.isload == 0 {
				VStack{
					Text(getRouteInfo.routeInfoData.routeId)
					Text(getRouteInfo.routeInfoData.routeName)
					Button(action: {
						getData2()
					}) {
						Image(systemName: "arrow.clockwise")
					}
					if (getRouteInfo.currentLocationDataLoad == 0){
						Text("\(getRouteInfo.RunningBus)대 운행중")
					}
					ScrollView{
						VStack(spacing: 0){
							ForEach(getRouteInfo.routeInfoData.stationLists, id: \.self){ item in
								if item.mobileNo == "via" {
									RouteDetailRowView(stationName: item.stationName, stationId: item.stationId, mobileNo: item.mobileNo, districtCd: item.districtCd, currentLocation: item.currentLocation)
								} else {
									NavigationLink(destination: StationDetailView(mobileNo: item.mobileNo, stationId: item.stationId)){
										
										RouteDetailRowView(stationName: item.stationName, stationId: item.stationId, mobileNo: item.mobileNo, districtCd: item.districtCd, currentLocation: item.currentLocation)
										
									}
								}
							}
							.buttonStyle(PlainButtonStyle())
						}
					}
				}
				.onAppear {
					print("getData2")
					getData2()
				}
			} else if getRouteInfo.isload == 1 {
				VStack{
					Text("정보를 받아오던중 오류가 발생했습니다.")
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
				VStack {
					Text("로딩중...")
				}
			}
		}
		.onAppear {
			getData()
		}
	}
	private func getData(){
		getRouteInfo.getDataFromServer(routeId: routeId)
	}
	private func getData2(){
		getRouteInfo.getCurrentLocationData(routeId: routeId)
	}
}

struct RouteDetailView_Previews: PreviewProvider {
	static var previews: some View {
		RouteDetailView(routeId: "234000150")
	}
}
