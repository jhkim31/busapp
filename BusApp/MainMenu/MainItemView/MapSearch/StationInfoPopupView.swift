//
//  StationInfoPopupView.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/01.
//

import SwiftUI
import MapKit

struct StationInfoPopupView: View {
	@Binding var popup: Bool
	var item: MyAnnotation
	var body: some View {
		GeometryReader { geometry in
			VStack{
				Spacer()
				VStack{
					HStack{
						Spacer()
						VStack{
							HStack{
								Spacer()
								Button(action: {
									popup = false
								}) {
									Text("닫기")
										.padding(5)
								}
							}
//							NavigationLink(destination: StationDetailView(stationId: item.stationId, mobileNo: item.stationName)){
//								Text(item.stationName)
//									.frame(width: geometry.size.width * 0.6, alignment: .leading)
//									
//							}
							ScrollView {
								NavigationLink(destination: StationDetailView(stationId: item.stationId, mobileNo: item.mobileNo)){
									Text("루트")
								}
								Text("hi")
							}
							.frame(width: geometry.size.width * 0.6, alignment: .leading)
						}
						.frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.6)
						.background(Color(red: 0.9, green: 0.9, blue: 0.9, opacity: 0.9))
						Spacer()
					}
				}
				Spacer()
			}
		}
	}
}

struct StationInfoPopupView_Previews: PreviewProvider {
	static var previews: some View {
		StationInfoPopupView(popup: .constant(true), item: MyAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.4, longitude: 127.0512), stationName: "hui", stationId: "hi", mobileNo: "hi", showStationName: false))
	}
}
