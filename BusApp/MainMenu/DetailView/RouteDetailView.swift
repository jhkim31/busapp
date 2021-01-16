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
						getData()
					}) {
						Image(systemName: "arrow.clockwise")
					}
					ScrollView{
						ForEach(getRouteInfo.routeInfoData.stationLists, id: \.self){ item in
							if item.mobileNo == "via" {
								ZStack{
									HStack{
										Text(item.stationName)
											.lineLimit(1)
											.foregroundColor(.gray)
										Text(item.stationId)
										Text(item.mobileNo)
										Text(item.districtCd)
										Spacer()
									}
									.font(.system(size:20))
									.padding(.leading, 30)
									.frame(height:50)
									.overlay(
										ZStack{
											HStack{
												Circle()
													.frame(width:10)
													.foregroundColor(.gray)
												Spacer()
											}
											.padding(.leading, 12)
											HStack{
												if(item.currentLocation){
													Image(systemName: "bus")
														.offset(y: 25)
														.foregroundColor(.green)
												}
												Spacer()
											}
											.padding(.leading, 5)
											Rectangle()
												.padding(.leading, 30)
												.frame(height:1)
												.offset(y:15)
												.foregroundColor(.gray)
										}
									)
								}
							} else {
								NavigationLink(destination: StationDetailView(mobileNo: item.mobileNo, stationId: item.stationId)){
									ZStack{
										HStack{
											Text(item.stationName)
												.lineLimit(1)
												.foregroundColor(.black)
											Text(item.stationId)
											Text(item.mobileNo)
											Text(item.districtCd)
											Spacer()
										}
										.font(.system(size:20))
										.padding(.leading, 30)
										.frame(height:50)
										.overlay(
											ZStack{
												HStack{
													Circle()
														.frame(width:10)
														.foregroundColor(.gray)
													Spacer()
												}
												.padding(.leading, 12)
												HStack{
													if(item.currentLocation){
														Image(systemName: "bus")
															.offset(y: 25)
															.foregroundColor(.green)
													}
													Spacer()
												}
												.padding(.leading, 5)
												
												Rectangle()
													.padding(.leading, 30)
													.frame(height:1)
													.offset(y:15)
													.foregroundColor(.gray)
											}
										)
									}
								}
							}
						}
					}
				}
				.onAppear {
					print("getData2")
					getData2()
				}
			} else if getRouteInfo.isload == 1 {
				VStack{
					Text(getRouteInfo.resultCode)
					Text(getRouteInfo.errMsg)
					Button(action: {
						getData()
					}) {
						HStack{
							Image(systemName: "arrow.clockwise")
							Text("다시 받아오기")
						}
					}
				}
			} else if getRouteInfo.isload == 2 {
				VStack{
					Text(getRouteInfo.routeInfoData.routeId)
					Text(getRouteInfo.routeInfoData.routeName)
					Text(getRouteInfo.resultCode)
					Text(getRouteInfo.errMsg)
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
