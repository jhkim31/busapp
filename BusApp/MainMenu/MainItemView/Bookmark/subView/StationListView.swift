//
//  StatioinListView.swift
//  BusApp
//
//  Created by 김재현 on 2020/12/27.
//

import SwiftUI

struct StationListView: View {
	
	var body: some View {
		VStack{
			NavigationLink(destination: StationDetailView(mobileNo: "54002", stationId: "234001018")) {
				Text("대주아파트 종점")
			}
			NavigationLink(destination: StationDetailView(mobileNo: "54153", stationId: "234001173")) {
				Text("경기광주역")
			}
		}
	}
}

struct StationListView_Previews: PreviewProvider {
	static var previews: some View {
		StationListView()
	}
}
