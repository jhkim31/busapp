//
//  RouteDetailView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct RouteDetailView: View {
	@ObservedObject var getRouteInfo = GetRouteInfo()
	var routeId: String
	var body: some View {
		VStack{
			if getRouteInfo.isload == 0 {
				VStack{
					Text(getRouteInfo.routeInfoData.routeId)
					Text(getRouteInfo.routeInfoData.routeName)
					ScrollView{
						ForEach(getRouteInfo.routeInfoData.stationLists, id: \.self){ item in
							NavigationLink(destination: StationDetailView(mobileNo: item.mobileNo, stationId: item.stationId)){
								HStack{
									Text(item.stationName)
									Text(item.stationId)
									Text(item.mobileNo)
								}
							}
						}
					}
				}
			} else if getRouteInfo.isload == 1 {
				Text(getRouteInfo.resultCode)
				Text(getRouteInfo.errMsg)
			} else if getRouteInfo.isload == 2 {
				Text(getRouteInfo.routeInfoData.routeId)
				Text(getRouteInfo.routeInfoData.routeName)
				Text(getRouteInfo.resultCode)
				Text(getRouteInfo.errMsg)
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
}

struct RouteDetailView_Previews: PreviewProvider {
	static var previews: some View {
		RouteDetailView(routeId: "234000150")
	}
}
