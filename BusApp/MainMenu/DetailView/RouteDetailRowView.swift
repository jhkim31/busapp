//
//  RouteDetailRowView.swift
//  BusApp
//
//  Created by 김재현 on 2021/01/16.
//

import SwiftUI

struct RouteDetailRowView: View {
	var stationName: String
	var stationId: String
	var mobileNo: String
	var districtCd: String
	var currentLocation: Bool
	var body: some View {
		ZStack{
			HStack{
				Image("arrowImage")
					.resizable()
					.scaledToFit()
					.padding(.leading, 30)
					.frame(height:65)
				HStack{
					Text(stationName)
						.lineLimit(1)
						.foregroundColor(.gray)
					Text(stationId)
					Text(mobileNo)
					Text(districtCd)
					Spacer()
				}
				.font(.system(size:20))
			}
			.frame(height:65)
			.border(Color.gray, width: 0.4)
			if (currentLocation) {
				HStack{
					Image("busImage")
						.resizable()
						.scaledToFit()
						.frame(height:30)
						.offset(x: 31, y: -35)
						.shadow(radius: 3)
					Spacer()
				}
			}
			
		}
	}
}

struct RouteDetailRowView_Previews: PreviewProvider {
	static var previews: some View {
		
		RouteDetailRowView(stationName: "123", stationId: "", mobileNo: "", districtCd: "", currentLocation: true)
		
	}
}

//
//import SwiftUI
//
//struct RouteDetailRowView: View {
//	var stationName: String
//	var stationId: String
//	var mobileNo: String
//	var districtCd: String
//	var currentLocation: Bool
//	var body: some View {
//		ZStack{
//			VStack{
//				Spacer()
//				HStack{
//					Text(stationName)
//						.lineLimit(1)
//						.foregroundColor(.gray)
//					Text(stationId)
//					Text(mobileNo)
//					Text(districtCd)
//					Spacer()
//				}
//				.font(.system(size:20))
//				.padding(.leading, 30)
//				.frame(height:65)
//				.overlay(
//					ZStack{
//						HStack{
//							if(currentLocation){
//								Image(systemName: "bus")
//									.offset(y: 25)
//									.foregroundColor(.green)
//							}
//							Spacer()
//						}
//						.padding(.leading, 5)
//						Rectangle()
//							.padding(.leading, 30)
//							.frame(height:1)
//							.offset(y:15)
//							.foregroundColor(.gray)
//					}
//				)
//				Spacer()
//			}
//		}
//	}
//}
//
//struct RouteDetailRowView_Previews: PreviewProvider {
//	static var previews: some View {
//		RouteDetailRowView(stationName: "123", stationId: "", mobileNo: "", districtCd: "", currentLocation: true)
//	}
//}
//
