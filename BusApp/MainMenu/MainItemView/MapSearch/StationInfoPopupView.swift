////
////  StationInfoPopupView.swift
////  BusApp
////
////  Created by 김재현 on 2021/01/01.
////
//
//import SwiftUI
//import MapKit
//
//struct StationInfoPopupView: View {
//	@Binding var popup: Bool
//	var item: MyAnnotation
//	var body: some View {
//		GeometryReader { geometry in
//			VStack{
//				Spacer()
//				VStack{
//					HStack{
//						Spacer()
//						
//						Spacer()
//					}
//				}
//				Spacer()
//			}
//		}
//	}
//}
//
//struct StationInfoPopupView_Previews: PreviewProvider {
//	static var previews: some View {
//		StationInfoPopupView(popup: .constant(true), item: MyAnnotation(coordinate: CLLocationCoordinate2D(latitude: 37.4, longitude: 127.0512), stationName: "hui", stationId: "hi", mobileNo: "hi", showStationName: false))
//	}
//}
